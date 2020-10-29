package AesEncriptor

import java.util.Base64
import javax.crypto.Cipher
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec
import kotlin.random.Random

fun main(args: Array<String>) {
    if (args.size != 2) {
        println("usage: aesKt srcfile keystring")
        System.exit(-1)
    }
    val fn = args[0]
    val key = args[1]
    //TODO
}

// mode: Cipher.ENCRYPT_MODE or Cipher.DECRYPT_MODE
fun ByteArray.cript(mode: Int): ByteArray {
    val key = SecretKeySpec("0123456789abcdef".toByteArray(), "AES")
    val iv = IvParameterSpec("0123456789abcdef".toByteArray())
    val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
    cipher.init(mode, key, iv)
    return cipher.doFinal(this)
}

fun solt() = Random.Default.nextBytes(8)
fun String.encript() = toByteArray(Charsets.UTF_8).let { solt() + it }.cript(Cipher.ENCRYPT_MODE).let { String(Base64.getEncoder().encode(it), Charsets.UTF_8) }
fun String.decript() = Base64.getDecoder().decode(this).cript(Cipher.DECRYPT_MODE).drop(8).let { String(it.toByteArray(), Charsets.UTF_8) }
