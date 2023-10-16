package ie.chrischen.library.net

import ie.chrischen.library.LibraryApplication
import ie.chrischen.library.event.FEvent
import ie.chrischen.library.event.IEvent
import ie.chrischen.library.util.NetChecker
import java.io.EOFException
import java.io.InterruptedIOException
import java.net.ConnectException
import java.net.HttpURLConnection
import java.net.SocketTimeoutException
import java.net.UnknownHostException

class HttpExceptionHandler {

    fun hasAvailableNetwork(id: String): IEvent {
        return if (!NetChecker.isAvailable(LibraryApplication.getInstance())) {
            FEvent(id, 0, MaitianErrorHandler.EMS.get(0))
        } else null
    }

    fun dispatchException(id: String?, e: Throwable): IEvent? {
        val event: IEvent
        if (e is HttpException) {
            val httpException: HttpException = e as HttpException
            val statusCode: Int = httpException.code()
            when (statusCode) {
                HttpURLConnection.HTTP_BAD_REQUEST -> event =
                    FEvent(id, 6, MaitianErrorHandler.EMS.get(6))

                HttpURLConnection.HTTP_UNAUTHORIZED, HttpURLConnection.HTTP_FORBIDDEN -> event =
                    FEvent(id, 12, MaitianErrorHandler.EMS.get(12))

                HttpURLConnection.HTTP_CLIENT_TIMEOUT -> event =
                    FEvent(id, 13, MaitianErrorHandler.EMS.get(13))

                HttpURLConnection.HTTP_GATEWAY_TIMEOUT -> event =
                    FEvent(id, 14, MaitianErrorHandler.EMS.get(14))

                HttpURLConnection.HTTP_NOT_FOUND, HttpURLConnection.HTTP_INTERNAL_ERROR, HttpURLConnection.HTTP_BAD_GATEWAY, HttpURLConnection.HTTP_UNAVAILABLE -> event =
                    FEvent(id, 3, MaitianErrorHandler.EMS.get(3))

                else -> if (statusCode >= 300 && statusCode <= 499) {
                    event = FEvent(id, 2, MaitianErrorHandler.EMS.get(2))
                } else if (statusCode >= 500 && statusCode <= 599) {
                    event = FEvent(id, 3, MaitianErrorHandler.EMS.get(3))
                } else {
                    event = FEvent(id, 4, MaitianErrorHandler.EMS.get(4))
                }
            }
        } else if (e is com.google.gson.JsonSyntaxException) {
            event = FEvent(id, 10, MaitianErrorHandler.EMS.get(10))
        } else if (e is UnknownHostException) {
            event = FEvent(id, 8, MaitianErrorHandler.EMS.get(8))
        } else if (e is EOFException) {
            event = FEvent(id, 5, MaitianErrorHandler.EMS.get(5))
        } else if (e is SocketTimeoutException) {
            event = FEvent(id, 9, MaitianErrorHandler.EMS.get(9))
        } else if (e is InterruptedIOException) {
            event = FEvent(id, 7, MaitianErrorHandler.EMS.get(7))
        } else if (e is ConnectException) {
            event = FEvent(id, 11, MaitianErrorHandler.EMS.get(11))
        } else {
            event = FEvent(id, 1, MaitianErrorHandler.EMS.get(1))
        }
        return event
    }
}