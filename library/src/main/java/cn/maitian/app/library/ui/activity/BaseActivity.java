package cn.maitian.app.library.ui.activity;

import android.os.Build;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;

import java.util.List;

import butterknife.ButterKnife;
import cn.maitian.app.library.core.ActivitiesManager;
import cn.maitian.app.library.event.BusProvider;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.ui.activity
 *
 * @Author: Chris Chen
 * @Time: 2019/4/19 15:42
 * @Description:
 */
public abstract class BaseActivity extends AppCompatActivity {

    //-----------------------------------------------------------
    protected FragmentManager fragmentManager;

    /**
     * This method will initialize when #{android.app.Activity} call onCreate;
     *
     * @param savedInstanceState data bundle.
     */
    protected abstract void startWork (Bundle savedInstanceState);

    /**
     * This method will initialize when #{android.app.Activity} call onDestroy
     */
    protected abstract void stopWork ();

    /**
     * Return the Activity's view
     *
     * @return the view of activity
     */
    protected abstract View getContentView ();

    @Override
    protected void onCreate (Bundle savedInstanceState) {
        fragmentManager = getSupportFragmentManager();
        ActivitiesManager.getAppManager().addActivity(this);
        super.onCreate(savedInstanceState);
        setContentView(getContentView());

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            setTranslucentStatus(true);
        }

        ButterKnife.bind(this);
        BusProvider.register(this);
        startWork(savedInstanceState);
    }

    @Override
    public void onAttachFragment (Fragment fragment) {
        super.onAttachFragment(fragment);
    }

    @Override
    public void onContentChanged () {
        super.onContentChanged();
    }

    @Override
    public void onPostCreate (Bundle savedInstanceState, PersistableBundle persistentState) {
        super.onPostCreate(savedInstanceState, persistentState);
    }

    @Override
    protected void onPostCreate (Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);
    }

    @Override
    protected void onStart () {
        super.onStart();
    }

    @Override
    protected void onResume () {
        super.onResume();
    }

    @Override
    protected void onPostResume () {
        super.onPostResume();
    }

    @Override
    protected void onPause () {
        super.onPause();
    }

    @Override
    protected void onSaveInstanceState (Bundle outState) {
        super.onSaveInstanceState(outState);
    }

    @Override
    protected void onStop () {
        super.onStop();
    }

    @Override
    protected void onDestroy () {
        List<Fragment> fragments = fragmentManager.getFragments();
        if (fragments != null && fragments.size() != 0) {
            for (Fragment fragment : fragments) fragment = null;
        }

        BusProvider.unregister(this);
        ButterKnife.unbind(this);
        stopWork();

        super.onDestroy();
        ActivitiesManager.getAppManager().removeActivity(this);
    }

    //-----------------------------------------------------------

    @Override
    public void onTrimMemory (int level) {
        super.onTrimMemory(level);
    }

    @Override
    public void onBackPressed () {
        if (fragmentManager != null && fragmentManager.getBackStackEntryCount() == 0) {
            finish();
        } else {
            fragmentManager.popBackStack();
        }
    }

    //-----------------------------------------------------------

    private void setTranslucentStatus (boolean on) {
        Window win = getWindow();
        WindowManager.LayoutParams winParams = win.getAttributes();
        final int bits = WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS;
        if (on) {
            winParams.flags |= bits;
        } else {
            winParams.flags &= ~bits;
        }
        win.setAttributes(winParams);
    }
}
