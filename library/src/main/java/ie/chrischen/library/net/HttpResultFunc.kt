package ie.chrischen.library.net

import ie.chrischen.library.bean.BaseModel
import ie.chrischen.library.bean.abs.IBean
import ie.chrischen.library.event.BeanEvent
import ie.chrischen.library.event.IEvent
import io.reactivex.rxjava3.functions.Function

internal class HttpResultFunction<T : IBean, E : BaseModel<T>>(private val _id: String) : Function<E, IEvent> {
    override fun apply(e: E): IEvent {
        val event = BeanEvent(_id, e.data);
        return event;
    }
}
