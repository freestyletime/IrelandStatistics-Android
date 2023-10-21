package cn.maitian.app.library.event;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.event
 *
 * @Author: Chris Chen
 * @Time: 2019/4/14 16:37
 * @Description:
 */
public class FEvent extends BaseEvent {
    public int code;
    public TYPE type;
    public String message;

    public FEvent (String id, TYPE type, int code, String message) {
        super(id);
        this.code = code;
        this.type = type;
        this.message = message;
    }

    /**
     * 错误类型
     *
     * B：Business error type
     * L：Besides business error type
     * */
    public enum TYPE {
        L,
        B
    }
}