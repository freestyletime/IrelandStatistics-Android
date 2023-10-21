package cn.maitian.app.library.network.download;

import android.app.DownloadManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;

import cn.maitian.app.library.ErrorHandler;
import cn.maitian.app.library.event.BusProvider;
import cn.maitian.app.library.event.FEvent;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.download
 *
 * @Author: Chris Chen
 * @Time: 2019/5/25 16:26
 * @Description: The file downloader for user.
 */
public final class DownloadHandler extends Handler {

    private Context _context;
    private DownloadManagerPro _pro;

    private void _remove (DownloadManagerPro pro, long index) {
        pro.removeDownload(index);
    }

    private void _download (Context context, DownloadManagerPro pro, Downloader downloader) {
        if (downloader == null) {
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 15, ErrorHandler.EMS.get(15)));
        } else {
            if (TextUtils.isEmpty(downloader.href)) {
                BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 16, ErrorHandler.EMS.get(16)));
            } else {
                String _apk = ".apk";
                String href = downloader.href;
                String dir = Environment.DIRECTORY_DOWNLOADS;

                if (href.toLowerCase().lastIndexOf(_apk) > 0) {
                    DownloadManager.Request request = new DownloadManager.Request(Uri.parse(href));

                    if (downloader.onlyWifi) {
                        request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI);
                    }

                    if (TextUtils.isEmpty(downloader.name)) {
                        request.setDestinationInExternalPublicDir(dir, href.substring(href.lastIndexOf("/") + 1));
                    } else {
                        request.setDestinationInExternalPublicDir(dir, downloader.name);
                    }

                    if (!TextUtils.isEmpty(downloader.description)) {
                        request.setDescription(downloader.description);
                    }

                    String mime = "application/vnd.android.package-archive";
                    request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
                    request.setMimeType(mime);
                    request.allowScanningByMediaScanner();
                    request.setVisibleInDownloadsUi(true);

                    long re = pro.startDownload(request);
                    if (!TextUtils.isEmpty(downloader.spName) && !TextUtils.isEmpty(downloader.spIndex)) {
                        SharedPreferences sp = context.getSharedPreferences(downloader.spName, Context.MODE_PRIVATE);
                        sp.edit().putLong(downloader.spIndex, re).apply();
                    }
                } else {
                    Intent intent = new Intent();
                    intent.setAction(Intent.ACTION_VIEW);
                    intent.setData(Uri.parse(href));
                    context.startActivity(intent);
                }
            }
        }
    }

    /**
     * Action of download
     */
    public static final int ACTION_FILE_DOWNLOAD = 0x00F9;
    /**
     * Action of cancel (only apk file)
     */
    public static final int ACTION_FILE_DOWNLOAD_CANCEL = 0x00FA;

    public DownloadHandler (Context context) {
        this._context = context;
        DownloadManager dm = (DownloadManager) context.getSystemService(Context.DOWNLOAD_SERVICE);
        this._pro = new DownloadManagerPro(dm);
    }

    @Override
    public void handleMessage (Message msg) {
        switch (msg.what) {
            case ACTION_FILE_DOWNLOAD:
                if (msg.obj instanceof Downloader) {
                    Downloader downloader = (Downloader) msg.obj;
                    _download(this._context, this._pro, downloader);
                }
                break;
            case ACTION_FILE_DOWNLOAD_CANCEL:
                if (msg.arg1 != 0) {
                    _remove(this._pro, msg.arg1);
                }
                break;
        }
    }

    /**
     * Get the instance of {@link DownloadManagerPro}
     */
    public DownloadManagerPro getDownloadManagerPro () {
        return _pro;
    }

    /**
     * A data entity serve for {{@link DownloadHandler}
     */
    public static class Downloader {
        /**
         * Name of download (only apk file)
         */
        public String name;
        /**
         * Url of download
         */
        public String href;
        /**
         * name of SharedPreferences of download (only apk file)
         */
        public String spName;
        /**
         * Index of SharedPreferences of download (only apk file)
         */
        public String spIndex;
        /**
         * Download only in the WiFi environment? (only apk file)
         */
        public boolean onlyWifi;
        /**
         * Description of download (only apk file)
         */
        public String description;
    }

}
