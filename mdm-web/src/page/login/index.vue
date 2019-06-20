<template>
  <div class="login-container"
       @keyup.enter.native="handleLogin">

    <div class="login-weaper  animated bounceInDown">
      <div class="login-left">
<!--        <div class="login-time">-->
<!--          {{time}}-->
<!--        </div>-->
        <img class="img"
             src="/img/logo.png"
             alt="">
        <p class="title">{{website.infoTitle}}</p>
        <p>v 1.0.0</p>
      </div>
      <div class="login-border">
        <div class="login-main">
<!--          <h4 class="login-title">-->
<!--            <el-select-->
<!--              class="login-select animated fadeIn"-->
<!--              v-model="active"-->
<!--              @change="handleCommand"-->
<!--              placeholder="点击请选择租户"-->
<!--              size="mini">-->
<!--              <el-option label="租户1 用户登录" value="1"></el-option>-->
<!--&lt;!&ndash;              <el-option label="租户2 用户登录" value="2"></el-option>&ndash;&gt;-->
<!--            </el-select>-->
<!--          </h4>-->
          <userLogin v-if="activeName==='user'"></userLogin>
          <codeLogin v-else-if="activeName==='code'"></codeLogin>
          <thirdLogin v-else-if="activeName==='third'"></thirdLogin>
          <div class="login-menu">
            <a href="#"
               @click.stop="activeName='user'">账号密码</a>
            <a href="#"
               @click.stop="activeName='code'">手机号登录</a>
<!--            <a href="#"-->
<!--               @click.stop="activeName='third'">第三方登录</a>-->
          </div>
        </div>

      </div>
    </div>
    <top-color v-show="false"></top-color>
  </div>
</template>
<script>
  import userLogin from "./userlogin";
  import codeLogin from "./codelogin";
  import thirdLogin from "./thirdlogin";
  import {mapGetters} from "vuex";
  import {getStore, setStore} from "@/util/store";
  import {dateFormat} from "@/util/date";
  import {validatenull} from "@/util/validate";
  import topColor from "@/page/index/top/top-color";

  export default {
    name: "login",
    components: {
      userLogin,
      codeLogin,
      thirdLogin,
      topColor
    },
    data() {
      return {
        time: "",
        active: "",
        activeName: "user",
        socialForm: {}
      };
    },
    watch: {
      $route: {
        handler() {
          const params = this.$route.query
          if (validatenull(params.state) && validatenull(params.code)) return

          this.socialForm.state = params.state
          this.socialForm.code = params.code
          const loading = this.$loading({
            lock: true,
            text: `登录中,请稍后。。。`,
            spinner: 'el-icon-loading'
          })
          this.$store.dispatch('LoginBySocial', this.socialForm).then(
            () => {
              loading.close()
              this.$router.push({path: this.tagWel.value});
            }).catch(() => {
            loading.close()
          })

        },
        immediate: true
      }
    },
    created() {
      this.active = getStore({name: "tenantId"});
      this.getTime();
      setInterval(() => {
        this.getTime();
      }, 1000);
    },
    mounted() {
    },
    computed: {
      ...mapGetters(["website",'tagWel'])
    },
    props: [],
    methods: {
      handleCommand(command) {
        setStore({name: "tenantId", content: command});
      },
      getTime() {
        this.time = dateFormat(new Date());
      }
    }
  };
</script>

<style lang="scss">
  .login-container {
    display: flex;
    align-items: center;
    position: relative;
    width: 100%;
    height: 100%;
    margin: 0 auto;
    background: #049ec4;
    /*background: url("/img/bg/banner04.png") 0 bottom repeat-x #049ec4;*/
    /*animation: animate-cloud 20s linear infinite;*/
  }

  .login-weaper {
    margin: 0 auto;
    width: 1000px;
    box-shadow: -4px 5px 10px rgba(0, 0, 0, 0.4);
  }

  .login-left,
  .login-border {
    position: relative;
    min-height: 500px;
    align-items: center;
    display: flex;
  }

  .login-left {
    border-top-left-radius: 5px;
    border-bottom-left-radius: 5px;
    justify-content: center;
    flex-direction: column;
    background-color: #409EFF;
    color: #fff;
    float: left;
    width: 50%;
    position: relative;
  }

  .login-left .img {
    width: 140px;
  }

  .login-time {
    position: absolute;
    left: 25px;
    top: 25px;
    width: 100%;
    color: #fff;
    font-weight: 200;
    opacity: 0.9;
    font-size: 18px;
    overflow: hidden;
  }

  .login-left .title {
    margin-top: 60px;
    text-align: center;
    color: #fff;
    font-weight: 300;
    letter-spacing: 2px;
    font-size: 25px;
  }

  .login-border {
    border-left: none;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;
    color: #fff;
    background-color: #fff;
    width: 50%;
    float: left;
    box-sizing: border-box;
  }

  .login-main {
    margin: 0 auto;
    width: 65%;
    box-sizing: border-box;
  }

  .login-main > h3 {
    margin-bottom: 20px;
  }

  .login-main > p {
    color: #76838f;
  }

  .login-title {
    color: #333;
    margin-bottom: 40px;
    font-weight: 500;
    font-size: 22px;
    text-align: center;
    letter-spacing: 4px;
  }

  .login-select {
    input {
      color: #333;
      font-size: 18px;
      font-weight: 400;
      border: none;
      text-align: center;
    }
  }

  .login-menu {
    margin-top: 40px;
    width: 100%;
    text-align: center;

    a {
      color: #999;
      font-size: 12px;
      margin: 0px 8px;
    }
  }

  .login-submit {
    width: 100%;
    height: 45px;
    border: 1px solid #409eff;
    background: none;
    font-size: 18px;
    letter-spacing: 2px;
    font-weight: 300;
    color: #409eff;
    cursor: pointer;
    margin-top: 30px;
    font-family: "neo";
    transition: 0.25s;
  }

  .login-form {
    margin: 10px 0;

    i {
      color: #333;
    }

    .el-form-item__content {
      width: 100%;
    }

    .el-form-item {
      margin-bottom: 12px;
    }

    .el-input {
      input {
        padding-bottom: 10px;
        text-indent: 5px;
        background: transparent;
        border: none;
        border-radius: 0;
        color: #333;
        border-bottom: 1px solid rgb(235, 237, 242);
      }

      .el-input__prefix {
        i {
          padding: 0 5px;
          font-size: 16px !important;
        }
      }
    }
  }

  .login-code {
    display: flex;
    align-items: center;
    justify-content: space-around;
    margin: 0 0 0 10px;
  }

  .login-code-img {
    margin-top: 2px;
    width: 100px;
    height: 38px;
    background-color: #fdfdfd;
    border: 1px solid #f0f0f0;
    color: #333;
    font-size: 14px;
    font-weight: bold;
    letter-spacing: 5px;
    line-height: 38px;
    text-indent: 5px;
    text-align: center;
  }
</style>
