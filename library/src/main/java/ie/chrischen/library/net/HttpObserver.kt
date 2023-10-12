package ie.chrischen.library.net

internal class HttpObserver(private val _id: String) : Subscriber<IEvent?>() {
    private val _handler: HttpExceptionHandler

    // --------------------------------------------------------------------
    // --------------------------------------------------------------------
    init {
        _handler = HttpExceptionHandler()
    }

    fun onStart() {
        var event: IEvent?
        if (_handler.hasAvailableNetwork(_id).also { event = it } != null) {
            BusProvider.post(event)
            unsubscribe()
        }
    }

    fun onNext(event: IEvent?) {
        if (event != null) {
            BusProvider.post(event)
        }
    }

    fun onCompleted() {
        BusProvider.post(BaseEvent(_id))
        unsubscribe()
    }

    fun onError(e: Throwable?) {
        BusProvider.post(_handler.dispatchException(_id, e))
    }
}