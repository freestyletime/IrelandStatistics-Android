package cn.maitian.app.library.network.image;

import android.content.Context;
import android.text.TextUtils;
import cn.maitian.app.library.utils.common.StringUtils;
import com.bumptech.glide.Glide;
import com.bumptech.glide.GlideBuilder;
import com.bumptech.glide.integration.okhttp3.OkHttpUrlLoader;
import com.bumptech.glide.load.DecodeFormat;
import com.bumptech.glide.load.engine.cache.DiskCache;
import com.bumptech.glide.load.engine.cache.DiskLruCacheFactory;
import com.bumptech.glide.load.engine.cache.ExternalCacheDiskCacheFactory;
import com.bumptech.glide.load.model.GlideUrl;
import com.bumptech.glide.module.GlideModule;

import java.io.File;
import java.io.InputStream;

/**
 * Created by IntelliJ IDEA in MaitianCommonLibrary
 * cn.maitian.app.library.network.image
 *
 * @Author: Chris Chen
 * @Time: 2019/4/20 11:04
 * @Description:
 */
public final class ImageStrategyModule implements GlideModule {

    private String _cachePath;
    private boolean _hQulity;

    public ImageStrategyModule (String cachePath, boolean _hQulity) {
        this._cachePath = cachePath;
        this._hQulity = _hQulity;
    }

    @Override
    public void applyOptions (Context context, GlideBuilder builder) {

        if (_hQulity) {
            builder.setDecodeFormat(DecodeFormat.PREFER_ARGB_8888);
        }

        if (StringUtils.isEmpty(_cachePath)) {
            builder.setDiskCache(new ExternalCacheDiskCacheFactory(context, DiskCache.Factory.DEFAULT_DISK_CACHE_SIZE));
        } else {
            builder.setDiskCache(new ImageDiskCacheFactory(this._cachePath, DiskCache.Factory.DEFAULT_DISK_CACHE_SIZE));
        }
    }

    @Override
    public void registerComponents (Context context, Glide glide) {
        glide.register(GlideUrl.class, InputStream.class, new OkHttpUrlLoader.Factory());
    }

    private final class ImageDiskCacheFactory extends DiskLruCacheFactory {
        private ImageDiskCacheFactory (final String cachePath, int diskCacheSize) {
            super(new CacheDirectoryGetter() {
                @Override
                public File getCacheDirectory () {
                    if (TextUtils.isEmpty(cachePath)) {
                        return null;
                    } else {
                        return new File(cachePath);
                    }
                }
            }, diskCacheSize);
        }
    }
}
