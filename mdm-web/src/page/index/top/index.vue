<template>
  <div class="avue-top">
    <div class="top-bar__left">
      <div class="avue-breadcrumb"
           :class="[{ 'avue-breadcrumb--active': isCollapse }]"
           v-if="showCollapse">
        <i class="icon-navicon"
           @click="setCollapse"></i>
      </div>
    </div>
    <div class="top-bar__title">
      <div class="top-bar__item top-bar__item--show"
           v-if="showMenu">
        <top-menu></top-menu>
      </div>
      <span class="top-bar__item"
            v-if="showSearch">
        <top-search></top-search>
      </span>
    </div>
    <div class="top-bar__right">
      <!--<el-tooltip v-if="showColor"-->
                  <!--effect="dark"-->
                  <!--content="主题色"-->
                  <!--placement="bottom">-->
        <!--<div class="top-bar__item">-->
          <!--<top-color></top-color>-->
        <!--</div>-->
      <!--</el-tooltip>-->
      <!--<el-tooltip v-if="showDebug"-->
                  <!--effect="dark"-->
                  <!--:content="logsFlag?'没有错误日志':`${logsLen}条错误日志`"-->
                  <!--placement="bottom">-->
        <!--<div class="top-bar__item">-->
          <!--<top-logs></top-logs>-->
        <!--</div>-->
      <!--</el-tooltip>-->
      <!--<el-tooltip v-if="showLock"-->
                  <!--effect="dark"-->
                  <!--content="锁屏"-->
                  <!--placement="bottom">-->
        <!--<div class="top-bar__item">-->
          <!--<top-lock></top-lock>-->
        <!--</div>-->
      <!--</el-tooltip>-->
      <el-tooltip v-if="showTheme"
                  effect="dark"
                  content="特色主题"
                  placement="bottom">
        <div class="top-bar__item top-bar__item--show">
          <top-theme></top-theme>
        </div>
      </el-tooltip>
      <!--<el-tooltip v-if="showFullScren"-->
                  <!--effect="dark"-->
                  <!--:content="isFullScren?'退出全屏':'全屏'"-->
                  <!--placement="bottom">-->
        <!--<div class="top-bar__item">-->
          <!--<i :class="isFullScren?'icon-tuichuquanping':'icon-quanping'"-->
             <!--@click="handleScreen"></i>-->
        <!--</div>-->
      <!--</el-tooltip>-->
      <el-tooltip v-if="this.userInfo.avatar"
                  effect="dark"
                  content="用户头像"
                  placement="bottom">
        <img id="thumbnail"
             class="top-bar__img">
      </el-tooltip>
      <el-dropdown>
        <span class="el-dropdown-link">
          {{userInfo.username}}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>
            <router-link to="/">首页</router-link>
          </el-dropdown-item>
          <el-dropdown-item>
            <router-link to="/info/index">个人信息</router-link>
          </el-dropdown-item>
          <el-dropdown-item @click.native="$refs.seting.open()"
                            divided>界面设置
          </el-dropdown-item>
          <el-dropdown-item @click.native="logout"
                            divided>退出系统
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
      <top-setting ref="seting"></top-setting>
    </div>
  </div>
</template>
<script>
  import {mapGetters, mapState} from "vuex";
  import {fullscreenToggel, handleImg, listenfullscreen} from "@/util/util";
  import topLock from "./top-lock";
  import topMenu from "./top-menu";
  import topSearch from "./top-search";
  import topTheme from "./top-theme";
  import topLogs from "./top-logs";
  import topColor from "./top-color";
  import topSetting from "./top-setting";

  export default {
    components: {
      topLock,
      topMenu,
      topSearch,
      topTheme,
      topLogs,
      topColor,
      topSetting
    },
    name: "top",
    data() {
      return {};
    },
    filters: {},
    created() {
      handleImg(this.userInfo.avatar, "thumbnail");
    },
    mounted() {
      listenfullscreen(this.setScreen);
    },
    computed: {
      ...mapState({
        showDebug: state => state.common.showDebug,
        showTheme: state => state.common.showTheme,
        showLock: state => state.common.showLock,
        showFullScren: state => state.common.showFullScren,
        showCollapse: state => state.common.showCollapse,
        showSearch: state => state.common.showSearch,
        showMenu: state => state.common.showMenu,
        showColor: state => state.common.showColor
      }),
      ...mapGetters([
        "userInfo",
        "isFullScren",
        "tagWel",
        "tagList",
        "isCollapse",
        "tag",
        "logsLen",
        "logsFlag"
      ])
    },
    methods: {
      handleScreen() {
        fullscreenToggel();
      },
      setCollapse() {
        this.$store.commit("SET_COLLAPSE");
      },
      setScreen() {
        this.$store.commit("SET_FULLSCREN");
      },
      logout() {
        this.$confirm("是否退出系统, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          this.$store.dispatch("LogOut").then(() => {
            this.$router.push({path: "/login"});
          });
        });
      }
    }
  };
</script>

<style lang="scss" scoped>
</style>
