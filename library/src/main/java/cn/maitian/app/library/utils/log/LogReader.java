package cn.maitian.app.library.utils.log;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.log
 *
 * @Author: Chris Chen
 * @Time: 2019/6/1 10:50
 * @Description:
 */
public class LogReader extends Thread {

    public static boolean open = true;
    private static LogReader instance = null;
    private static Process mLogcatProc = null;

    private BufferedReader mReader = null;
    private String packageName = "*";
    private String logPath = "/sdcard/MTLog.log";

    public static void startCatchLog (String packageName, String logPath) {
        if (!open) return;
        if (instance == null) {
            instance = new LogReader();
            instance.packageName = packageName;
            if(logPath == null) {
                instance.logPath = logPath;
            }
            instance.start();
        }
    }

    public static void stopCatchLog () {
        if (!open) return;
        if (mLogcatProc != null) {
            mLogcatProc.destroy();
            mLogcatProc = null;
        }
    }

    @Override
    public void run () {
        BufferedWriter bw = null;
        try {
            mLogcatProc = Runtime.getRuntime().exec("logcat " + packageName + ":I");
            mReader = new BufferedReader(new InputStreamReader(mLogcatProc.getInputStream()));

            if(Log.isPrint){
                logSystemInfo();
            }

            String line;
            File file = new File(logPath);
            if (file.exists() && isFileSizeOutof10M(file)) {
                file.delete();
            }
            if (!file.exists()) {
                Log.i("log file path >>> :'" + logPath + "' >>> is not exists.");
            }
            FileWriter fw = new FileWriter(file, true);
            bw = new BufferedWriter(fw);
            while ((line = mReader.readLine()) != null) {
                bw.append(line);
                bw.newLine();
                bw.flush();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (mReader != null) {
                    mReader.close();
                    mReader = null;
                }
                if (bw != null) {
                    bw.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            instance = null;
        }

    }

    /**
     * 判断文件是否大于10M。
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static boolean isFileSizeOutof10M (File file) throws Exception {
        if (file == null) return false;
        return file.length() >= 10485760;
    }

    public static void logSystemInfo () {
        Date date = new Date(System.currentTimeMillis());
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = dateFormat.format(date);
        android.util.Log.w("system", "New Start $$$$$$$$$$$$$$###########   " + time + "############$$$$$$$$$$$$$$$");
        android.util.Log.w("system", "android.os.Build.BOARD:" + android.os.Build.BOARD);
        android.util.Log.w("system", "android.os.Build.MODEL:" + android.os.Build.MODEL);
        android.util.Log.w("system", "android.os.Build.DEVICE:" + android.os.Build.DEVICE);
        android.util.Log.w("system", "android.os.Build.PRODUCT:" + android.os.Build.PRODUCT);
        android.util.Log.w("system", "android.os.Build.MANUFACTURER:" + android.os.Build.MANUFACTURER);
        android.util.Log.w("system", "android.os.Build.VERSION.CODENAME:" + android.os.Build.VERSION.CODENAME);
        android.util.Log.w("system", "android.os.Build.VERSION.RELEASE:" + android.os.Build.VERSION.RELEASE);
        android.util.Log.w("system", "android.os.Build.VERSION.SDK:" + android.os.Build.VERSION.SDK);
    }
}
