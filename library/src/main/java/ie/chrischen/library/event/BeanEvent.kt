package ie.chrischen.library.event

import ie.chrischen.library.bean.abs.IBean

class BeanEvent<E : IBean?>(id: String?, val e: List<E>) : BaseEvent(id)