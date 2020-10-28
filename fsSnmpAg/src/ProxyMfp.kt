package gdvm.mfp.mib

import com.google.cloud.firestore.FirestoreOptions
import FirestoreInterOp.firestoreDocumentFlow
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.first
import kotlinx.serialization.Serializable
import mibtool.*
import mibtool.snmp4jWrapper.from
import mibtool.snmp4jWrapper.sendFlow
import mibtool.snmp4jWrapper.toSnmp4j
import org.snmp4j.Snmp
import org.snmp4j.transport.DefaultUdpTransportMapping
import java.util.*

val firestore = FirestoreOptions.getDefaultInstance().getService()!!
val snmp = Snmp(DefaultUdpTransportMapping().apply { listen() })

@Serializable
data class Request(
        // TODO: スケジュール設定
        val interval: Long = 1 * 60_000,
)

@Serializable
data class Report(
        val deviceId: String,
        val type: String = "mfp.mib",
        val time: Long = Date().time,
        val result: Result,
)

@Serializable
data class Result(
        val pdu: PDU,
)


@ExperimentalCoroutinesApi
suspend fun runMfp(deviceId: String, target: SnmpTarget) = coroutineScope {
    println("Started Device ${deviceId}")
    try {
        val oids = listOf(PDU.sysName, PDU.sysDescr, PDU.sysObjectID, PDU.hrDeviceStatus, PDU.hrPrinterStatus, PDU.hrPrinterDetectedErrorState)
        val res = snmp.sendFlow(
                target = target.toSnmp4j(),
                pdu = PDU.GETNEXT(vbl = oids.map { VB(it) }).toSnmp4j()
        ).first()

        val rep = Report(
                deviceId = deviceId, type = "mfp.mib", time = Date().time,
                result = Result(
                        pdu = PDU.from(res.response)
                ),
        )

        // ログと最新状態それぞれ書込み
        firestore.collection("devLog").document().set(rep).get() //TODO:BLocking code
        firestore.collection("device").document(deviceId).set(rep).get() //TODO:BLocking code

        firestore.firestoreDocumentFlow<Request> { collection("devConfig").document(deviceId) }.collectLatest {
            // インスタンス設定に応じた処理(あれば)
            println(it)
        }
    } catch (e: Exception) {
        println("Exception in $deviceId")
        e.printStackTrace()
    } finally {
        println("Terminated Device ${deviceId}")
    }
}
