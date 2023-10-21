package cn.maitian.app.library;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library
 *
 * @Author: Chris Chen
 * @Time: 2019/5/25 17:11
 * @Description:
 */
public class ErrorHandler {

    // ---- Http ----
    private static final String MSG_NET_EOF = LibraryApplication.getInstance().getString(R.string.msg_net_eof);
    private static final String MSG_NET_OFF = LibraryApplication.getInstance().getString(R.string.msg_net_off);
    private static final String MSG_SOCKET_TIME_OUT = LibraryApplication.getInstance().getString(R.string.msg_socket_timeout);
    private static final String MSG_CONN_TIME_OUT = LibraryApplication.getInstance().getString(R.string.msg_connection_timeout);
    private static final String MSG_CHECK_NET = LibraryApplication.getInstance().getString(R.string.msg_check_net);
    private static final String MSG_NONE_ERROR = LibraryApplication.getInstance().getString(R.string.msg_none_error);
    private static final String MSG_BAD_REQUEST = LibraryApplication.getInstance().getString(R.string.msg_bad_request);
    private static final String MSG_UNKNOWNS_HOST = LibraryApplication.getInstance().getString(R.string.msg_unknow_host);
    private static final String MSG_SYNTAX_ERROR = LibraryApplication.getInstance().getString(R.string.msg_syntax_error);
    private static final String MSG_CLIENT_ERROR = LibraryApplication.getInstance().getString(R.string.msg_client_error);
    private static final String MSG_SERVER_ERROR = LibraryApplication.getInstance().getString(R.string.msg_server_error);
    private static final String MSG_CONNECT_ERROR = LibraryApplication.getInstance().getString(R.string.msg_connect_error);
    private static final String MSG_PERMISSION_DENY = LibraryApplication.getInstance().getString(R.string.msg_perssion_deny);
    private static final String MSG_CLIENT_TIMEOUT = LibraryApplication.getInstance().getString(R.string.msg_client_timeout);
    private static final String MSG_GATEWAY_TIMEOUT = LibraryApplication.getInstance().getString(R.string.msg_gateway_timeout);

    // ---- Download ----
    private static final String MSG_DOWNLOAD_ENTITY = LibraryApplication.getInstance().getString(R.string.msg_download_entity);
    private static final String MSG_DOWNLOAD_URL = LibraryApplication.getInstance().getString(R.string.msg_download_url);

    // ---- Database ----
    private static final String MSG_DB_CREATE_FAILURE = LibraryApplication.getInstance().getString(R.string.msg_db_create_failure);
    private static final String MSG_DB_DELETE_FAILURE = LibraryApplication.getInstance().getString(R.string.msg_db_create_failure);
    private static final String MSG_DB_OPERATE_FAILURE = LibraryApplication.getInstance().getString(R.string.msg_db_operate_failure);
    private static final String MSG_DB_SAVE_FAILURE = LibraryApplication.getInstance().getString(R.string.msg_db_save_failure);
    private static final String MSG_DB_QUERY_FAILURE = LibraryApplication.getInstance().getString(R.string.msg_db_query_failure);

    public static String L_ID = "Maitian";
    public static int CODE_EMPTY = -1;
    public static Map<Integer, String> EMS = new HashMap<>();

    static {
        EMS.put(0, MSG_NET_OFF);
        EMS.put(1, MSG_CHECK_NET);
        EMS.put(2, MSG_CLIENT_ERROR);
        EMS.put(3, MSG_SERVER_ERROR);
        EMS.put(4, MSG_NONE_ERROR);
        EMS.put(5, MSG_NET_EOF);
        EMS.put(6, MSG_BAD_REQUEST);
        EMS.put(7, MSG_SOCKET_TIME_OUT);
        EMS.put(8, MSG_UNKNOWNS_HOST);
        EMS.put(9, MSG_CONN_TIME_OUT);
        EMS.put(10, MSG_SYNTAX_ERROR);
        EMS.put(11, MSG_CONNECT_ERROR);
        EMS.put(12, MSG_PERMISSION_DENY);
        EMS.put(13, MSG_CLIENT_TIMEOUT);
        EMS.put(14, MSG_GATEWAY_TIMEOUT);

        EMS.put(15, MSG_DOWNLOAD_ENTITY);
        EMS.put(16, MSG_DOWNLOAD_URL);

        EMS.put(17, MSG_DB_CREATE_FAILURE);
        EMS.put(18, MSG_DB_DELETE_FAILURE);
        EMS.put(19, MSG_DB_OPERATE_FAILURE);
        EMS.put(20, MSG_DB_SAVE_FAILURE);
        EMS.put(21, MSG_DB_QUERY_FAILURE);
    }

}
