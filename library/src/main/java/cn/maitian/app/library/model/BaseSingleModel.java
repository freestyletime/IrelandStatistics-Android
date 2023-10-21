package cn.maitian.app.library.model;

import cn.maitian.app.library.model.abs.IBean;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.model
 *
 * @Author: Chris Chen
 * @Time: 2019/4/13 15:01
 * @Description:
 */
public class BaseSingleModel<T extends IBean> extends BaseModel {
    public T pager;
}
