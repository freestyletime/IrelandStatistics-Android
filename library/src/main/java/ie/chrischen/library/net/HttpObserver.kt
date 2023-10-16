package ie.chrischen.library.net

import ie.chrischen.library.event.BaseEvent
import ie.chrischen.library.event.BusProvider
import ie.chrischen.library.event.IEvent
import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.disposables.Disposable

class HttpObserver(private val _id: String) : Observer<IEvent> {

    val _handler = HttpExceptionHandler()

    // --------------------------------------------------------------------
    // --------------------------------------------------------------------

    override fun onSubscribe(d: Disposable)
    {
        BusProvider.post(_handler.hasAvailableNetwork(_id))
    }

    override fun onNext(event: IEvent) {
        BusProvider.post(event)
    }

    override fun onComplete() {
        BusProvider.post(BaseEvent(_id))
    }

    override fun onError(e: Throwable) {
        BusProvider.post(_handler.dispatchException(_id, e))
    }
}