package ie.chrischen.library.net

import ie.chrischen.library.bean.BaseModel
import ie.chrischen.library.event.BeanEvent
import ie.chrischen.library.event.IEvent
import io.reactivex.rxjava3.functions.Function

internal class HttpResultFunction<E : BaseModel?>(private val _id: String?) : Function<E, IEvent?> {
    fun call(e: E): IEvent {
        val event: IEvent
        when (e.status) {
            SUCCESS_CODE -> if (e is BaseSingleModel) {
                val bsm: BaseSingleModel = e as BaseSingleModel
                event = BeanEvent(_id, bsm.data)
            } else if (e is BaseMultiModel) {
                val blm: BaseMultiModel = e as BaseMultiModel
                event = BeansEvent(_id, blm.data)
            } else {
                event = BaseEvent(_id)
            }

            else -> event = FEvent(_id, e.status, e.message)
        }
        return event
    }

    companion object {
        private const val SUCCESS_CODE = 1000
    }
}
