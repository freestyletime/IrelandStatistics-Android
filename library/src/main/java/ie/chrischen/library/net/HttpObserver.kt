package ie.chrischen.library.net

import ie.chrischen.library.event.BaseEvent
import ie.chrischen.library.event.BusProvider
import ie.chrischen.library.event.IEvent
import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.disposables.Disposable

class HttpObserver(private val _id: String) : Observer<IEvent> {

    private val _handler: HttpExceptionHandler

    // --------------------------------------------------------------------
    // --------------------------------------------------------------------
    init {
        _handler = HttpExceptionHandler()
    }

    override fun onSubscribe(d: Disposable)
    {
        var event: IEvent?
        if (_handler.hasAvailableNetwork(_id).also { event = it } != null) {
            BusProvider.post(event)
            unsubscribe()
        }
    }

    override fun onNext(event: IEvent) {
        if (event != null) {
            BusProvider.post(event)
        }
    }

    override fun onComplete() {
        BusProvider.post(BaseEvent(_id))
        unsubscribe()
    }

    override fun onError(e: Throwable) {
        BusProvider.post(_handler.dispatchException(_id, e))
    }
}