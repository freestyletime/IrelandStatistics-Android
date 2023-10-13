package ie.chrischen.library.event

open class BaseEvent : IEvent{
    var id: String? = null

    constructor(id: String?){
        this.id = id
    }
}