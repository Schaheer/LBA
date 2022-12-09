package cordova.plugin.abl;

import com.example.abl.R;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class OTP_Verification extends AppCompatActivity {

    private EditText otp1;
    private EditText otp2;
    private EditText otp3;
    private EditText otp4;
    private EditText otp5;
    private EditText otp6;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        String package_name = getApplication().getPackageName();
        setContentView(getApplication().getResources().getIdentifier("otp_verification", "layout", package_name));
        
        otp1 = findViewById(R.id.et_otp1);
        otp2 = findViewById(R.id.et_otp2);
        otp3 = findViewById(R.id.et_otp3);
        otp4 = findViewById(R.id.et_otp4);
        otp5 = findViewById(R.id.et_otp5);
        otp6 = findViewById(R.id.et_otp6);

        Intent i = getIntent();

        System.out.println(i.getStringExtra(CNIC_Availability.ACCOUNT_NUMBER));
        System.out.println(i.getStringExtra(CNIC_Availability.CNIC_NUMBER));

    }

    public void OTPVerification(View view) {
        System.out.println("Function called");
        if (isEmpty(otp1) || isEmpty(otp4) ||
                isEmpty(otp2) || isEmpty(otp5) ||
                isEmpty(otp3) || isEmpty(otp6)) {

            Toast.makeText(view.getContext(), "OTP fields Empty", Toast.LENGTH_SHORT).show();
            return;
        }
        Toast.makeText(view.getContext(), "We can proceed", Toast.LENGTH_SHORT).show();
    }

    public Boolean isEmpty(EditText et) {
        if (et.getText().toString().equals("") || et.getText().toString().equals("-")) {
            return true;
        }
        return false;
    }

    public void cancelActivity(View view) {
        finish();
    }
}