package cn.maitian.app.library.utils.test;

import cn.maitian.app.library.utils.common.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA in maimai_a
 * cn.maitian.app.library.utils.test
 *
 * @Author: Chris Chen
 * @Time: 2019/7/8 15:32
 * @Description:
 *      Test data
 */
public class InitializeConverter {

    public static final String DEFAULT_STRING = "InitializeConverter";
    public static final int DEFAULT_INTEGER = 1;
    public static final float DEFAULT_FLOAT = 1.0f;
    public static final double DEFAULT_DOUBLE = 1.0;

    private String strSeed;
    private int intSeed;
    private float floatSeed;
    private double doubleSeed;
    private String packageName;

    public InitializeConverter(String packageName) {
        this(packageName, DEFAULT_STRING, DEFAULT_INTEGER, DEFAULT_FLOAT, DEFAULT_DOUBLE);
    }

    public InitializeConverter(String packageName, String strSeed, int intSeed, float floatSeed,
                               double doubleSeed) {
        this.strSeed = strSeed;
        this.intSeed = intSeed;
        this.floatSeed = floatSeed;
        this.doubleSeed = doubleSeed;
        if (StringUtils.isEmpty(packageName)) {
            throw new IllegalArgumentException("package name must not be empty");
        }
        this.packageName = packageName;
    }

    @SuppressWarnings("unchecked") public Object from(Class service) {
        Object object = null;
        try {
            object = service.newInstance();

            Field[] fields = service.getDeclaredFields();
            for (Field field : fields) {
                Class fieldClass = field.getType();
                if (fieldClass == String.class) {
                    assign(field, object, strSeed);
                }
                if (fieldClass == int.class) {
                    assign(field, object, intSeed);
                }
                if (fieldClass == float.class) {
                    assign(field, object, floatSeed);
                }
                if (fieldClass == double.class) {
                    assign(field, object, doubleSeed);
                }
                if (isCustomObject(fieldClass)) {
                    assign(field, object, from(fieldClass));
                }
                if (fieldClass.isAssignableFrom(List.class)) {
                    List list = new ArrayList<>();
                    list.add(from(getGenericType(field))); //Only add one element for initialization
                    assign(field, object, list);
                }
            }
        } catch (InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }

        return object;
    }

    /**
     * Whether this class created by developer or not
     *
     * @param c target class
     */
    private boolean isCustomObject(Class c) {
        Package pack = c.getPackage();
        if (pack != null) {
            String name = pack.getName();
            if (!StringUtils.isEmpty(name)) {
                if (name.startsWith(packageName)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Assign a given value to specific field of a target object
     *
     * @throws IllegalAccessException
     */
    private void assign(Field field, Object object, Object value) throws IllegalAccessException {
        boolean accessible = field.isAccessible();
        field.setAccessible(true);
        field.set(object, value);
        field.setAccessible(accessible);
    }

    /**
     * Returns the generic type of this field.
     *
     * @return the generic type
     */
    public Class getGenericType(Field field) {
        ParameterizedType parameterizedType = (ParameterizedType) field.getGenericType();
        Type[] types = parameterizedType.getActualTypeArguments();
        return (Class) types[0];
    }
}
