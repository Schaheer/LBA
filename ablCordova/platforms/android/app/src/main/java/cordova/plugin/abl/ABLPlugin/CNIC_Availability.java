package cordova.plugin.abl;

import com.example.abl.R;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class CNIC_Availability extends AppCompatActivity {
    public static String ACCOUNT_NUMBER = "account_number";
    public static String CNIC_NUMBER = "cnic_number";

    private EditText etAccNumber;
    private EditText etCnicNumber;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String package_name = getApplication().getPackageName();
        setContentView(getApplication().getResources().getIdentifier("cnic_availability", "layout", package_name));
        getSupportActionBar().setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
        // getSupportActionBar().setCustomView(R.layout.custom_toolbar);
        // ColorDrawable colorDrawable = new ColorDrawable(Color.parseColor("#0F9D58"));
        getSupportActionBar().setBackgroundDrawable(new ColorDrawable(Color.parseColor("#FFA500")));

        etAccNumber = findViewById(R.id.et_accNumber);
        etCnicNumber = findViewById(R.id.et_cnicNumber);
    }

    public void nextActivity(View view) {
        if (isEmpty(etAccNumber) ||
                isEmpty(etCnicNumber)) {
            Toast.makeText(view.getContext(), "Please fill all * fields", Toast.LENGTH_LONG).show();
            return;
        }
        Intent i = new Intent(view.getContext(), OTP_Verification.class);
        i.putExtra(ACCOUNT_NUMBER, etAccNumber.getText().toString());
        i.putExtra(CNIC_NUMBER, etCnicNumber.getText().toString());
        startActivityForResult(i, 1);
    }

    public Boolean isEmpty(EditText et) {
        if (et.getText().toString().equals("")) {
            return true;
        }
        return false;
    }

    public void cancelActivity(View view) {
        finish();
    }
}