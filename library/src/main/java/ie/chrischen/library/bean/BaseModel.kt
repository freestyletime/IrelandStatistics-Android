package ie.chrischen.library.bean

import ie.chrischen.library.bean.abs.IBean
import ie.chrischen.library.bean.abs.IModel

class BaseModel<T : IBean> : IModel {
    var data : List<T>? = null
}