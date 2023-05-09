package com.example.flutter_zdh;

import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import org.devio.flutter.splashscreen.SplashScreen;

public class MainActivity extends FlutterActivity {
    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {

        SplashScreen.show(this,true);
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
