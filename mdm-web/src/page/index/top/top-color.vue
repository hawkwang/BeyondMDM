<template>
  <el-color-picker size="mini"
                   style="padding-top:18px;"
                   class="theme-picker"
                   :predefine="predefineColors"
                   popper-class="theme-picker-dropdown"
                   v-model="themeVal"></el-color-picker>
</template>

<script>
import color from "@/mixins/color";
export default {
  name: "topColor",
  mixins: [color()],
  data() {
    return {
      chalk: "",
      predefineColors: [
        '#ff4500',
        '#ff8c00',
        '#ffd700',
        '#90ee90',
        '#00ced1',
        '#1e90ff',
        '#c71585'
      ]
    };
  }
};
</script>

<style>
.theme-picker .el-color-picker__trigger {
  vertical-align: middle;
}

.theme-picker-dropdown .el-color-dropdown__link-btn {
  display: none;
}
</style>
