package cn.maitian.app.library.model;

import java.util.List;

import cn.maitian.app.library.model.abs.IBean;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.model
 *
 * @Author: Chris Chen
 * @Time: 2019/4/13 15:02
 * @Description:
 */
public class BaseMultiModel<T extends IBean> extends BaseModel {
    public List<T> pager;
}
