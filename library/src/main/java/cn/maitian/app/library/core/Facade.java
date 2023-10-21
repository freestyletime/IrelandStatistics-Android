package cn.maitian.app.library.core;

import android.annotation.SuppressLint;
import android.content.Context;
import cn.maitian.app.library.db.DBHelper;
import cn.maitian.app.library.db.abs.IDao;
import cn.maitian.app.library.network.download.DownloadHandler;
import cn.maitian.app.library.network.http.HttpManager;
import cn.maitian.app.library.network.image.ImageManager;
import cn.maitian.app.library.utils.common.StringUtils;
import cn.maitian.app.library.utils.io.FileUtils;

import java.io.File;
import java.util.List;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.core
 *
 * @Author: Chris Chen
 * @Time: 2019/4/13 13:51
 * @Description: All services' centre
 */
public final class Facade {

    private Facade () { }

    private static Facade facade = new Facade();

    private static DBHelper dbHelper;

    @SuppressLint("StaticFieldLeak")
    private static DownloadHandler downloadHandler;

    private static CacheManager cacheManager;

    private static HttpManager httpManager;

    private static ImageManager imageManager;

    private static ActivitiesManager activitiesManager;

    private static SubscriptionManager subscriptionManager;


    public static Facade init (Context context, String dbPath, String dbName, int dbVersion, List<IDao> daos,
                              String imgCachePath, boolean hQulity, String cachePath) {

        if (dbHelper == null) {
            if(!StringUtils.isEmpty(dbPath)) {
                FileUtils.mkdir(new File(dbPath));
                dbHelper = DBHelper.get(context, dbPath, dbName, dbVersion, daos);
            }
        }

        if (subscriptionManager == null) {
            subscriptionManager = new SubscriptionManager();
        }

        if (downloadHandler == null) {
            downloadHandler = new DownloadHandler(context);
        }

        if (httpManager == null) {
            httpManager = new HttpManager();
        }

        if (imageManager == null) {
            if(!StringUtils.isEmpty(imgCachePath)) {
                FileUtils.mkdir(new File(imgCachePath));
                imageManager = new ImageManager(context, imgCachePath, hQulity);
            }
        }

        if (cacheManager == null) {
            if(!StringUtils.isEmpty(cachePath)) {
                FileUtils.mkdir(new File(cachePath));
                cacheManager = CacheManager.get(cachePath);
            }
        }

        return facade;
    }

    /**
     * Get DBManager service
     */
    public static DBHelper getDbHelper () {
        return dbHelper;
    }

    /**
     * Get SubscriptionManager service
     */
    public static SubscriptionManager getSubscriptionManager () {
        return subscriptionManager;
    }

    /**
     * Get DownloadHandler
     */
    public static DownloadHandler getDownloadHandler () {
        return downloadHandler;
    }

    /**
     * Get HttpManager service
     */
    public static HttpManager getHttpManager () {
        return httpManager;
    }


    /**
     * Get ImageManager service
     */
    public static ImageManager getImageManager () {
        return imageManager;
    }

    /**
     * Get CacheManager service
     */
    public static CacheManager getCacheManager () {
        return cacheManager;
    }

    /**
     * Get ActivitiesManager service
     *
     * @return the object of ActivitiesManager
     */
    public static ActivitiesManager getActivitiesManager () {
        return ActivitiesManager.getAppManager();
    }
}
