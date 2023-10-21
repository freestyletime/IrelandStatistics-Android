package cn.maitian.app.library.ui.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

import cn.maitian.app.library.model.abs.IBean;
import cn.maitian.app.library.ui.holder.AbsHolderCategory;
import cn.maitian.app.library.ui.holder.AbsHolderFactory;
import cn.maitian.app.library.ui.holder.AbsViewHolder;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.adapter
 *
 * @Author: Chris Chen
 * @Time: 2019/4/27 11:52
 * @Description:
 */
public final class MaitianRecyclerViewAdapter extends RecyclerView.Adapter<AbsViewHolder> {

    private Context _context;
    private List<IBean> _beans;
    private AbsHolderFactory _factory;
    private AbsHolderCategory _category;

    public MaitianRecyclerViewAdapter (Context context, List<IBean> beans, AbsHolderFactory factory, AbsHolderCategory category) {
        this._beans = beans;
        this._context = context;
        this._factory = factory;
        this._category = category;
    }

    @Override
    public int getItemViewType (int position) {
        return _category.getItemType(_beans.get(position));
    }

    @Override
    public AbsViewHolder onCreateViewHolder (ViewGroup viewGroup, int type) {
        return _factory.getHolder(LayoutInflater.from(viewGroup.getContext()), viewGroup, type);
    }

    @Override
    public void onBindViewHolder (AbsViewHolder holder, int position) {
        holder.setView(_context, _beans.get(position));
    }

    @Override
    public int getItemCount () {
        return _beans == null ? 0 : _beans.size();
    }

    @Override
    public long getItemId (int position) {
        return position;
    }
}
