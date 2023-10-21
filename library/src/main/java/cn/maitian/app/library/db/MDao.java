package cn.maitian.app.library.db;

import cn.maitian.app.library.ErrorHandler;
import cn.maitian.app.library.db.abs.IDao;
import cn.maitian.app.library.event.BusProvider;
import cn.maitian.app.library.event.FEvent;
import com.j256.ormlite.dao.Dao;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by IntelliJ IDEA in maimai_a
 * cn.maitian.app.library.db
 *
 * @Author: Chris Chen
 * @Time: 2019/6/23 14:13
 * @Description:
 */
public class MDao<T extends IDao> {

    private Dao<T, Integer> dao;

    public MDao (DBHelper helper, Class<T> clazz) {
        try {
            dao = helper.getDao(clazz);
        } catch (SQLException e) {
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 19, ErrorHandler.EMS.get(19)));
            e.printStackTrace();
            dao = null;
        }
    }

    public int save (T t) {
        if (dao == null) return ErrorHandler.CODE_EMPTY;

        try {
            return dao.create(t);
        } catch (SQLException e) {
            e.printStackTrace();
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 20, ErrorHandler.EMS.get(20)));
            return ErrorHandler.CODE_EMPTY;
        }
    }

    public List<T> queryAll () {
        if (dao == null) return null;

        try {
            return dao.queryForAll();
        } catch (SQLException e) {
            e.printStackTrace();
            BusProvider.post(new FEvent(ErrorHandler.L_ID, FEvent.TYPE.L, 21, ErrorHandler.EMS.get(21)));
            return null;
        }
    }
}
