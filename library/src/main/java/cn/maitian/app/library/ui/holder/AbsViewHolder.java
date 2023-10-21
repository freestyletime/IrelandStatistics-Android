package cn.maitian.app.library.ui.holder;

import android.content.Context;
import android.view.View;

import androidx.recyclerview.widget.RecyclerView;

import butterknife.ButterKnife;
import cn.maitian.app.library.model.abs.IBean;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.holder
 *
 * @Author: Chris Chen
 * @Time: 2019/4/26 14:21
 * @Description:
 */
public abstract class AbsViewHolder<T extends IBean> extends RecyclerView.ViewHolder {

    public AbsViewHolder (View itemView) {
        super(itemView);
        ButterKnife.bind(this, itemView);
    }

    public abstract void setView (Context context, T t);
}
