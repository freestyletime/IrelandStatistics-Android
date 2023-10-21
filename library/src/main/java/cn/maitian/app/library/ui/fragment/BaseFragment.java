package cn.maitian.app.library.ui.fragment;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;

import butterknife.ButterKnife;
import cn.maitian.app.library.event.BusProvider;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.fragment
 *
 * @Author: Chris Chen
 * @Time: 2019/4/20 10:28
 * @Description:
 */
public abstract class BaseFragment extends Fragment {

    /**
     * This method will initialize when #{android.support.v4.app.Fragment} call onCreate();
     *
     * @param savedInstanceState data bundle.
     */
    protected abstract void beforeWork (Bundle savedInstanceState);

    /**
     * This method will initialize when #{android.support.v4.app.Fragment} call onActivityCreated();
     *
     * @param savedInstanceState data bundle.
     */
    protected abstract void startWork (Bundle savedInstanceState);

    /**
     * This method will initialize when #{android.support.v4.app.Fragment} call onDestroy();
     */
    protected abstract void stopWork ();

    /**
     * Return the Fragment's view
     *
     * @return the view of fragment
     */
    protected abstract View getContentView (LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState);


    @Override
    public void onAttach (Context context) {
        super.onAttach(context);
        BusProvider.register(this);
    }

    @Override
    public void onCreate (Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        beforeWork(savedInstanceState);
    }

    @Override
    public View onCreateView (LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View contentView = getContentView(inflater, container, savedInstanceState);
        ButterKnife.bind(this, contentView);
        return contentView;
    }

    @Override
    public void onViewCreated (View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
    }

    @Override
    public void onActivityCreated (@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        startWork(savedInstanceState);
    }

    @Override
    public void onViewStateRestored (Bundle savedInstanceState) {
        super.onViewStateRestored(savedInstanceState);
    }

    @Override
    public void onStart () {
        super.onStart();
    }

    @Override
    public void onResume () {
        super.onResume();
    }

    @Override
    public void onPause () {
        super.onPause();
    }

    @Override
    public void onStop () {
        super.onStop();
    }

    @Override
    public void onDestroyView () {
        ButterKnife.unbind(this);
        super.onDestroyView();
    }

    @Override
    public void onDestroy () {
        stopWork();
        super.onDestroy();
    }

    @Override
    public void onDetach () {
        super.onDetach();
        BusProvider.unregister(this);
    }
}
