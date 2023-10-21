package cn.maitian.app.library.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.text.TextUtils;
import cn.maitian.app.library.ErrorHandler;
import cn.maitian.app.library.db.abs.IDao;
import cn.maitian.app.library.event.BusProvider;
import cn.maitian.app.library.event.FEvent;
import com.j256.ormlite.android.apptools.OrmLiteSqliteOpenHelper;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;

import java.io.File;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by IntelliJ IDEA in maimai_a
 * cn.maitian.app.library.db
 *
 * @Author: Chris Chen
 * @Time: 2019/6/23 14:22
 * @Description:
 */
public class DBHelper extends OrmLiteSqliteOpenHelper {

    private String path;
    private String dbName;
    private String nalName;

    private List<IDao> daos;

    private static DBHelper dbh;

    private DBHelper (Context context, String path, String dbName, int dbVersion, List<IDao> daos) {
        super(context, dbName, null, dbVersion);
        this.dbName = dbName;
        this.nalName = dbName + "-journal";

        this.path = path;
        this.daos = daos;
        detect(path, dbName);
    }

    private void detect (String path, String dbName) {

        SQLiteDatabase db = null;
        try {
            File dbFile = new File(path, dbName);
            if (!dbFile.exists()) {
                db = SQLiteDatabase.openOrCreateDatabase(dbFile, null);
                onCreate(db);
            }
        } catch (Exception e) {
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 17, ErrorHandler.EMS.get(17)));
        } finally {
            if (db != null) db.close();
        }

    }

    // -----------------------------------------------------------

    public static synchronized DBHelper get (Context context, String path, String dbName, int dbVersion, List<IDao> daos) {

        if (TextUtils.isEmpty(path)) {
            throw new IllegalArgumentException("DBHelper::get >>> path can not be empty");
        }

        if (TextUtils.isEmpty(dbName)) {
            throw new IllegalArgumentException("DBHelper::get >>> dbName can not be empty");
        }

        if (daos == null || daos.size() == 0) {
            throw new IllegalArgumentException("DBHelper::get >>> dao can not be empty");
        }

        synchronized (DBHelper.class) {
            if (dbh == null) {
                dbh = new DBHelper(context.getApplicationContext(), path, dbName, dbVersion, daos);
            }
        }

        return dbh;
    }

    // -----------------------------------------------------------


    @Override
    public void onCreate (SQLiteDatabase database, ConnectionSource connectionSource) {
        try {
            for (IDao dao : daos) {
                TableUtils.createTable(connectionSource, dao.getClass());
            }
        } catch (SQLException e) {
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 17, ErrorHandler.EMS.get(17)));
            e.printStackTrace();
        }
    }

    @Override
    public void onUpgrade (SQLiteDatabase database, ConnectionSource connectionSource, int oldVersion, int newVersion) {
        //TODO Database Upgrade
    }

    /**
     * Delete database
     */
    public void delete () {
        File db = new File(path, dbName);
        File nal = new File(path, nalName);
        try {
            if (db.exists()) db.delete();
            if (nal.exists()) nal.delete();
        } catch (Exception e) {
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 18, ErrorHandler.EMS.get(18)));
            e.printStackTrace();
        }
    }

}

// -----------------------------------------------------------