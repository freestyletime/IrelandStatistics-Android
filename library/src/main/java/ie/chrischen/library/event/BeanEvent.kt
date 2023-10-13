package ie.chrischen.library.event

import ie.chrischen.library.bean.abs.IBean

class BeanEvent<E : IBean?>(id: String?, var e: E) : BaseEvent(id)