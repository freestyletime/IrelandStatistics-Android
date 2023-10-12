package ie.chrischen.library.net

import okhttp3.Interceptor
import okhttp3.Response
import java.io.IOException

internal class HttpInterceptor : Interceptor {
    private var _headers: Map<String, String>? = null

    constructor()
    constructor(headers: Map<String, String>?) {
        _headers = headers
    }

    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        val builder = chain.request().newBuilder()
        if (_headers != null) {
            val entrys = _headers!!.entries
            entrys.forEach{ e -> builder.addHeader(e.key, e.value); };
        }
        val request =
            builder //.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8")
                //                        .addHeader("Accept-Encoding", "gzip, deflate")
                .addHeader("Connection", "keep-alive")
                .addHeader("User-Agent", "Android")
                .addHeader("Accept", "application/json")
                .build()
        return chain.proceed(request)
    }
}