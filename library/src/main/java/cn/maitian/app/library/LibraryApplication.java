package cn.maitian.app.library;

import android.app.Application;

import com.facebook.stetho.Stetho;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library
 *
 * @Author: Chris Chen
 * @Time: 2019/4/13 13:50
 * @Description:
 */
public class LibraryApplication extends Application {

    private static LibraryApplication _instance;

    private void initStetho () {
        Stetho.initialize(
                Stetho.newInitializerBuilder(this)
                        .enableDumpapp(Stetho.defaultDumperPluginsProvider(this))
                        .enableWebKitInspector(Stetho.defaultInspectorModulesProvider(this))
                        .build());
    }

    public static LibraryApplication getInstance () {
        return _instance;
    }

    @Override
    public void onCreate () {
        super.onCreate();
        _instance = this;

        initStetho();
    }
}
