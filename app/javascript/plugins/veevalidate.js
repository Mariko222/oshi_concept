import Vue from 'vue'
import { ValidationProvider, ValidationObserver, extend } from "vee-validate";
import { required, email, min, max, confirmed, image, url } from "vee-validate/dist/rules";

Vue.component('ValidationObserver', ValidationObserver)
Vue.component('ValidationProvider', ValidationProvider)

extend("required", {
  ...required,
  message: "{_field_}は必須項目です",
});

extend("max", {
  ...max,
  message: "{_field_}は{length}文字以下で入力してください",
});

extend("min", {
  ...min,
  message: "{_field_}は{length}文字以上で入力してください",
});

extend("email", {
  ...email,
  message: "メールアドレスの形式で入力してください",
});

extend("confirmed", {
  ...confirmed,
  message: "パスワードと一致しません",
});

extend("image", {
  ...image,
  message: "{_field_}は画像形式で入力してください"
});

extend("url", {
  message: "URLを入力してください",
  validate(value) {
    return isURL(value, { protocols: ["https", "http"] });
  }
});

export default {
  components: {
    ValidationProvider,
    ValidationObserver,
  },
};
