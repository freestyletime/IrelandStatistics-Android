package ie.chrischen.library.event

import com.squareup.otto.Bus

object BusProvider {
    private val _bus = Bus()
    fun <T : IEvent?> post(t: T) {
        _bus.post(t)
    }

    fun register(obj: Any?) {
        _bus.register(obj)
    }

    fun unregister(obj: Any?) {
        _bus.unregister(obj)
    }
}