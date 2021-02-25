import io.ktor.client.*
import io.ktor.client.request.*

suspend fun main() {
    // Deviceの初期化の処理
    // 認証略

    val client = HttpClient()

    val result: String = client.post("http://localhost:8080") {
        body = """
            device(id:"DEV1") {
                schedule
                ipRange
                snmpCred
            }
        """.trimIndent()
    }
    // Device初期化処理

    client.close()
}