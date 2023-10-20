package ie.chrischen.library

import android.app.Application
import android.content.Context
import android.content.ContextWrapper
import com.facebook.stetho.Stetho

class LibraryApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        Stetho.initialize(
            Stetho.newInitializerBuilder(this)
            .enableDumpapp(Stetho.defaultDumperPluginsProvider(this))
            .enableWebKitInspector(Stetho.defaultInspectorModulesProvider(this))
            .build())
    }

    companion object {
        @JvmStatic
        lateinit var INSTANCE: LibraryApplication
    }
}

object AppContext : ContextWrapper(LibraryApplication.INSTANCE)