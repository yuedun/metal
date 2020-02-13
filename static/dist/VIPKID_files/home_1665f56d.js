webpackJsonp([2], {
    1: function (e, t, i) {
        "use strict";
        var n = i(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(n); (0, a.
                default)(function () {
                    ({
                        isIpadBox:
                            !0,
                        init: function () {
                            this.eventClick(),
                                this.skip(),
                                this.eventClickToggleNavigation(),
                                this.padMenu(),
                                this.registerJump(),
                                this.loginJump()
                        },
                        registerJump: function () {
                            (0, a.
                                default)("#registerHeaderBtn,#padRegisterHeaderBtn").on("click",
                                    function () {
                                        vkTrack.click("parent_pc_signup_click_head"),
                                            window.location.href = "/signup"
                                    })
                        },
                        loginJump: function () {
                            (0, a.
                                default)("#loginHeaderBtn,#padLoginHeaderBtn").on("click",
                                    function () {
                                        vkTrack.click("parent_pc_login_click_head"),
                                            window.location.href = "/login"
                                    })
                        },
                        padMenu: function () {
                            (0, a.
                                default)("#systemMenu").click(function () {
                                    (0, a.
                                        default)("#systemMenu .menu-box").toggle()
                                })
                        },
                        eventClick: function () {
                            var e = !0; (0, a.
                                default)("#navBtn").on("click",
                                    function () {
                                        e ? ((0, a.
                                            default)("body,html").css("overflow", "hidden"), (0, a.
                                                default)("body").addClass("active"), (0, a.
                                                    default)("#navLiderLeft").addClass("sliderbarShow"), e = !1) : ((0, a.
                                                        default)("body,html").css("overflow", "auto"), (0, a.
                                                            default)("body").removeClass("active"), (0, a.
                                                                default)("#navLiderLeft").removeClass("sliderbarShow"), e = !0)
                                    })
                        },
                        getRequest: function () {
                            var e = window.location.search,
                                t = new Object;
                            if (- 1 != e.indexOf("?")) for (var i = e.substr(1), n = i.split("&"), a = 0; a < n.length; a++) t[n[a].split("=")[0]] = decodeURI(n[a].split("=")[1]);
                            return t
                        },
                        skip: function () {
                            var e = {};
                            if (window.location.search.substr(1).split("&").forEach(function (t) {
                                var i = t.split("=");
                                e[i[0]] = i[1]
                            }), e.hasOwnProperty("channel_id")) {
                                var t = e.channel_id; (0, a.
                                    default)(".header-info-pc a, .header-info-ipad a").each(function () {
                                        var e = (0, a.
                                            default)(this).attr("href"); (0, a.
                                                default)(this).attr("href", e + "?channel_id=" + t)
                                    })
                            }
                        },
                        eventClickToggleNavigation: function () {
                            var e = window.location.pathname;
                            if (e.length <= 1) return void (0, a.
                                default)(".sy").addClass("active");
                            switch (e = e.split("/")[2]) {
                                case "home":
                                    (0, a.
                                        default)(".sy").addClass("active");
                                    break;
                                case "teachers":
                                    (0, a.
                                        default)(".bmsz").addClass("active");
                                    break;
                                case "advantage":
                                    (0, a.
                                        default)(".kctx").addClass("active"),
                                        (0, a.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, a.
                                            default)(".kctxys").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "mc":
                                    (0, a.
                                        default)(".kctx").addClass("active"),
                                        (0, a.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, a.
                                            default)(".zxk").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "vae":
                                    (0, a.
                                        default)(".kctx").addClass("active"),
                                        (0, a.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, a.
                                            default)(".qxjjkc").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "classlist":
                                    (0, a.
                                        default)(".gkk").addClass("active");
                                    break;
                                case "step":
                                    (0, a.
                                        default)(".rhsk").addClass("active");
                                    break;
                                case "download":
                                    (0, a.
                                        default)(".xzzx").addClass("active");
                                    break;
                                case "aboutus":
                                case "news":
                                    (0, a.
                                        default)(".zxdt").addClass("active")
                            }
                        }
                    }).init()
                })
    },
    2: function (e, t, i) {
        "use strict";
        var n = i(0); (0,
            function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(n).
                default)(function () {
                    ({
                        init:
                            function () { }
                    }).init()
                })
    },
    3: function (e, t, i) {
        "use strict";
        var n = i(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(n); (0, a.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.eventChange(),
                                    this.eventClickVktrackFooterSecond()
                            },
                        eventChange: function () {
                            (0, a.
                                default)("#goToWeibo").click(function () {
                                    window.location.href = "http://weibo.com/p/1006065212940492"
                                })
                        },
                        eventClickVktrackFooterSecond: function () {
                            (0, a.
                                default)("#onlineZxFooterBtn").click(function () {
                                    vkTrack.click("parent_pc_footer_consult_box")
                                })
                        }
                    }).init()
                })
    },
    4: function (e, t, i) {
        "use strict";
        var n = i(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(n); (0, a.
                default)(function () {
                    var e = !1; ({
                        init: function () {
                            this.scrollScreenHeight(),
                                this.httpClickRegisterAuditions(),
                                this.goBackTop(),
                                this.eventClickToggleRightFix(),
                                this.eventClickCloseBottom()
                        },
                        goBackTop: function () {
                            (0, a.
                                default)("#goBackBtn").click(function () {
                                    return (0, a.
                                        default)("html,body").animate({
                                            scrollTop:
                                                0
                                        },
                                            1e3),
                                        !1
                                })
                        },
                        scrollScreenHeight: function () {
                            (0, a.
                                default)(window).scroll(function () {
                                    (0, a.
                                        default)(window).scrollTop() >= .5 * (0, a.
                                            default)(window).height() && !e ? ((0, a.
                                                default)("#sectionBottom").addClass("active"), (0, a.
                                                    default)("#sectionBottom").removeClass("hideB"), (0, a.
                                                        default)("#goBackBtn").show()) :
                                    ((0, a.
                                        default)("#sectionBottom").removeClass("active"), (0, a.
                                            default)("#sectionBottom").addClass("hideB"), (0, a.
                                                default)("#goBackBtn").hide()),
                                    (0, a.
                                        default)(window).scrollTop() >= .5 * (0, a.
                                            default)(window).height() ? (0, a.
                                                default)("#goBackBtn").show() :
                                        (0, a.
                                            default)("#goBackBtn").hide(),
                                    (0, a.
                                        default)(window).scrollTop() + (0, a.
                                            default)(window).height() >= (0, a.
                                                default)(document).height() - (0, a.
                                                    default)(".footer").height() && ((0, a.
                                                        default)("#sectionBottom").removeClass("active"), (0, a.
                                                            default)("#sectionBottom").addClass("hideB"), (0, a.
                                                                default)("#goBackBtn").show())
                                })
                        },
                        compile: function (e) {
                            for (var t = String.fromCharCode(e.charCodeAt(0) + e.length), i = 1; i < e.length; i++) t += String.fromCharCode(e.charCodeAt(i) + e.charCodeAt(i - 1));
                            return escape(t)
                        },
                        IsPcPage: function () {
                            var e = 0,
                                t = navigator.userAgent,
                                i = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"],
                                n = !0;
                            for (this.isPcBox = !0, e = 0; e < i.length; e++) if (t.indexOf(i[e]) > 0) {
                                n = !1,
                                    this.isPcBox = !1;
                                break
                            }
                            return n
                        },
                        httpClickRegisterAuditions: function () {
                            var e = /^1[3-9][0-9]{9}$/,
                                t = this; (0, a.
                                    default)("#fixClickBottomBtn").click(function () {
                                        var i = (0, a.
                                            default)(".registerAuditions").val();
                                        i && e.test(i) ? (i = t.compile(i), vkTrack.click("parent_pc_bottom_signup_click_box"), location.href = "/signup?&mobile=" + i) : (0, a.
                                            default)("#bottomErrorTips").show()
                                    }),
                                    (0, a.
                                        default)("#fixRightBtn").click(function () {
                                            vkTrack.click("parent_pc_consult_fix_click_th")
                                        })
                        },
                        eventClickToggleRightFix: function () {
                            (0, a.
                                default)("#qrcodeTouchBtn").on("touchend",
                                    function () {
                                        (0, a.
                                            default)("#erweima").toggle()
                                    }),
                            (0, a.
                                default)("#telTouchBtn").on("touchend",
                                    function () {
                                        (0, a.
                                            default)("#teltips").toggle()
                                    })
                        },
                        eventClickCloseBottom: function () {
                            (0, a.
                                default)("#closeBtnBottom").click(function () {
                                    e = !0,
                                        vkTrack.click("parent_pc_bottom_signup_click_close"),
                                        (0, a.
                                            default)("#sectionBottom").removeClass("active"),
                                        (0, a.
                                            default)("#sectionBottom").addClass("hideB")
                                })
                        }
                    }).init()
                })
    },
    6: function (e, t, i) {
        "use strict";
        function n() {
            (0, o.
                default)("body").delegate("[data-video]", "click",
                    function () {
                        function e() {
                            return !!document.createElement("video").canPlayType
                        }
                        function t() {
                            var t = "",
                                i = "";
                            l.hasClass("hide") || (t = (0, o.
                                default)(window).width(), i = (0, o.
                                    default)(window).height(), l.css({
                                        width: t,
                                        height: i,
                                        display: "block"
                                    }), e() ? l.children("video").css({
                                        width: t,
                                        height: i
                                    }) : (l.children("object").attr("style", "width:" + t + "px;height:" + i + "px;"), l.find("embed").attr("style", "width:" + t + "px;height:" + i + "px;")))
                        }
                        var i = "",
                            n = "",
                            a = "",
                            c = "",
                            l = "",
                            d = "",
                            r = "",
                            s = "",
                            u = "",
                            f = "",
                            h = "",
                            v = "",
                            p = ""; (0, o.
                                default)("body").css("overflow", "hidden"),
                                i = (0, o.
                                    default)(window).width(),
                                n = (0, o.
                                    default)(window).height(),
                                a = (0, o.
                                    default)(this).attr("data-video"),
                                c = (0, o.
                                    default)(this).attr("data-video-flv"),
                                l = (0, o.
                                    default)('<div id="videoPop"></div>'),
                                d = (0, o.
                                    default)('<div id="videoCloseBtn"><img style="width: 100%" src="./static/dist/VIPKID_files/1539676842708-guanbi.png"></div>'),
                                r = {
                                    width: "100%",
                                    position: "fixed",
                                    left: 0,
                                    top: 0,
                                    "z-index": 1010,
                                    display: "none",
                                    background: "rgb(0, 0, 0)",
                                    height: n
                                },
                                s = {
                                    width: 38,
                                    "border-radius": "50%",
                                    position: "absolute",
                                    top: 12,
                                    right: 14,
                                    cursor: "pointer",
                                    transition: "all 0.2s"
                                },
                                u = {
                                    opacity: 1
                                },
                                f = {
                                    color: "#fff",
                                    "text-align": "center",
                                    position: "relative",
                                    "margin-top": "-10px",
                                    top: "50%"
                                },
                                h = {
                                    opacity: .7
                                },
                                l.addClass("hide"),
                                l.css(r),
                                d.css(s),
                                d.hover(function () {
                                    d.css(u)
                                },
                                    function () {
                                        d.css(h)
                                    }),
                                (0, o.
                                    default)("body").append(l),
                                l.removeClass("hide").fadeIn(),
                                e() ? (p = '<video src="' + a + '" type="video/mp4" width="' + i + '" height="' + n + '" autoplay="autoplay" controls="true" style="background:#000 url(\'https://image.vipkid.com.cn/market/file/1539715751879-videoload.gif\') no-repeat center"></video>', l.append(p), l.children("video").bind("ended",
                                    function () {
                                        (0, o.
                                            default)("body").css("overflow", "auto"),
                                        l.removeClass("show").fadeOut(200),
                                        (0, o.
                                            default)(this).parent().addClass("hide").hide(),
                                        (0, o.
                                            default)(this).remove()
                                    })) :
                                    (c ? (v += '<object codebase="//download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"  id="videoObject" width="' + i + '" height="' + n + '" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">', v += '<param name="quality" value="high" />', v += '<param name="allowFullScreen" value="true" />', v += '<param name="wmode" value="transparent" />', v += '<param name="wmode" value="opaque" />', v += '<param name="movie" value="//resource.vipkid.com.cn/parent_portal/images/flvplayer.swf" />', v += '<param name="FlashVars"  value="vcastr_file=' + c + '&amp;IsAutoPlay=1&amp;IsShowBar=0" />', v += '<embed src="//resource.vipkid.com.cn/parent_portal/images/flvplayer.swf" flashvars="vcastr_file=' + c + '&amp;IsAutoPlay=1&amp;IsShowBar=0" width="' + i + '" height="' + n + '" pluginspage=" http://www.macromedia.com/go/getflashplayer" quality="high" allowfullscreen="true" type="application/x-shockwave-flash"  wmode="transparent" /></object>') : (v = (0, o.
                                        default)('<div>暂不支持当前格式的视频播放，请用最新版的<a href="/download" style="color:#fff;margin: 5px">Chrome浏览器</a>打开本站</div>'), v.css(f)), l.append(v)),
                                l.append(d),
                                (0, o.
                                    default)(window).on("resize", t),
                                d.click(function () {
                                    (0, o.
                                        default)("body").css("overflow", "auto"),
                                    (0, o.
                                        default)(this).siblings().remove(),
                                    (0, o.
                                        default)(this).parent().addClass("hide").hide(),
                                    (0, o.
                                        default)(window).unbind("resize", t)
                                })
                    })
        }
        var a = i(0),
            o = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(a);
        e.exports = n
    },
    73: function (e, t, i) {
        "use strict";
        function n(e) {
            return e && e.__esModule ? e : {
                default:
                    e
            }
        }
        i(74),
            i(4),
            i(1),
            i(75),
            i(3),
            i(2);
        var a = i(0),
            o = n(a),
            c = i(6),
            l = n(c); (0, o.
                default)(function () {
                    ({
                        init:
                            function () {
                                (0, l.
                                    default)(),
                                this.rewardCarousel(),
                                this.eventClickShowVideo(),
                                this.eventClickTeachers(),
                                this.eventClickLiutao(),
                                this.eventVkTrackClickHome(),
                                this.redirectMobile(),
                                this.googleJudge(),
                                this.videoAutoPlay()
                            },
                        googleJudge: function () {
                            o.
                                default.getScript("https://www.google-analytics.com/analytics.js").done(function () {
                                    vkTrack.trigger("parent_pc_google_click_t")
                                }).fail(function () {
                                    vkTrack.trigger("parent_pc_google_click_f")
                                })
                        },
                        videoAutoPlay: function () {
                            document.getElementById("jsVideoBoxCon").ontimeupdate = function () {
                                (0, o.
                                    default)("#jsVideoBgPoster").hide()
                            }
                        },
                        redirectMobile: function () {
                            for (var e = navigator.userAgent,
                                t = ["Android", "iPhone", "SymbianOS", "Windows Phone"], i = 0; i < t.length; i++) if (e.indexOf(t[i]) > 0) {
                                    location.href = "https://mobile.vipkid.com.cn/";
                                    break
                                }
                        },
                        rewardCarousel: function () {
                            function e(e, t) {
                                d = e > r ? 1 : e,
                                    a.stop().animate({
                                        left: -1 * i * (e + 3) / 4
                                    },
                                        {
                                            duration: u,
                                            complete: t
                                        })
                            }
                            function t(t) {
                                s = +new Date;
                                var n = void 0;
                                return t > 0 ? (n = d + 1, n > r + 1 && (n = 0), n <= r ? e(n) : e(n,
                                    function () {
                                        a.css({
                                            left: -i / 4 * 4
                                        })
                                    })) : (n = d - 1) > -3 ? e(n) : (n < -3 && (n = 5, e(n)), -3 == n ? e(n,
                                        function () {
                                            a.css({
                                                left: -i / 4 * c
                                            })
                                        }) : void 0)
                            }
                            var i = (0, o.
                                default)("#rewardBox").width(),
                                n = (0, o.
                                    default)("#show"),
                                a = n.find("> div.img > .box"),
                                c = a.children().length;
                            a.children().eq(0).clone().appendTo(a),
                                a.children().eq(1).clone().appendTo(a),
                                a.children().eq(2).clone().appendTo(a),
                                a.children().eq(3).clone().appendTo(a);
                            for (var l = 0; l < c; l++) l <= 3 && a.children().eq(c - 1).clone().prependTo(a);
                            a.css({
                                left: -i
                            });
                            var d = 0,
                                r = c,
                                s = 0,
                                u = 600;
                            t(1);
                            var f = !0,
                                h = (0, o.
                                    default)(".arrowBtn");
                            h.delegate("s", "click",
                                function () {
                                    f && (f = !1, t((0, o.
                                        default)(this).is(".prev") ? -1 : 1), setTimeout(function () {
                                            f = !0
                                        },
                                            1e3))
                                }).appendTo(n),
                                n.hover(function (e) {
                                    h.stop()["fade" + ("mouseenter" == e.type ? "In" : "Out")]("fast")
                                });
                            var v = void 0;
                            "autoPlay" == n.attr("rel") && (v = setInterval(function () {
                            + new Date - s < 3e3 || t(1)
                            },
                                3e3), a.mouseover(function () {
                                    clearInterval(v)
                                }), a.mouseout(function () {
                                    v = setInterval(function () {
                                    + new Date - s < 3e3 || t(1)
                                    },
                                        3e3)
                                })),
                                (0, o.
                                    default)("#show .img .con").width(i / 4),
                                (0, o.
                                    default)("#show").css("width", i),
                                (0, o.
                                    default)("#show .img").css("width", i);
                            var p = 0,
                                k = 0,
                                g = 0,
                                m = !1,
                                w = document.querySelector("#show"),
                                _ = (0, o.
                                    default)("#show").width();
                            w.addEventListener("touchstart",
                                function (e) {
                                    clearInterval(v),
                                        p = e.touches[0].clientX
                                }),
                                w.addEventListener("touchmove",
                                    function (e) {
                                        k = e.touches[0].clientX,
                                            g = k - p,
                                            m = !0,
                                            v = setInterval(function () {
                                            + new Date - s < 3e3 || t(1)
                                            },
                                                3e3)
                                    }),
                                w.addEventListener("touchend",
                                    function () {
                                        m && Math.abs(g) > _ / 5 && (t(g > 0 ? -1 : 1), m = !1)
                                    })
                        },
                        eventClickShowVideo: function () {
                            (0, o.
                                default)(".play-btn").click(function () {
                                    (0, o.
                                        default)("#play-video").show(),
                                    (0, o.
                                        default)("#play-video video").trigger("play")
                                })
                        },
                        eventClickTeachers: function () {
                            (0, o.
                                default)(".teachers-btn").click(function () {
                                    (0, o.
                                        default)("#teachers-video").show(),
                                    (0, o.
                                        default)("#teachers-video video").trigger("play")
                                })
                        },
                        eventClickLiutao: function () {
                            (0, o.
                                default)(".liutao-btn").click(function () {
                                    (0, o.
                                        default)("#liutao-video").show(),
                                    (0, o.
                                        default)("#liutao-video video").trigger("play")
                                })
                        },
                        eventVkTrackClickHome: function () {
                            (0, o.
                                default)("#homeOneVideo").click(function () {
                                    vkTrack.click("parent_pc_consult_fix_video_f")
                                }),
                            (0, o.
                                default)("#homeTwoVideo").click(function () {
                                    vkTrack.click("parent_pc_consult_fix_video_s")
                                }),
                            (0, o.
                                default)("#freeClickSignup").click(function () {
                                    vkTrack.click("parent_pc_signup_click_button_free")
                                }),
                            (0, o.
                                default)("#learnOne").click(function () {
                                    vkTrack.click("parent_pc_signup_click_yanxuan")
                                }),
                            (0, o.
                                default)("#learnTwo").click(function () {
                                    vkTrack.click("parent_pc_signup_click_guojijiaocai")
                                }),
                            (0, o.
                                default)("#learnThree").click(function () {
                                    vkTrack.click("parent_pc_signup_click_rengongzhineng")
                                }),
                            (0, o.
                                default)("#learnFour").click(function () {
                                    vkTrack.click("parent_pc_signup_click_yiduiyi")
                                }),
                            (0, o.
                                default)("#learnFive").click(function () {
                                    vkTrack.click("parent_pc_signup_click_guojihuatuandui")
                                }),
                            (0, o.
                                default)("#learnSix").click(function () {
                                    vkTrack.click("parent_pc_signup_click_jinrushijiaoxue")
                                }),
                            (0, o.
                                default)("#teacherDahuiBtn").click(function () {
                                    vkTrack.click("parent_pc_consult_fix_video_t")
                                }),
                            (0, o.
                                default)("#homeToTeachersBtn").click(function () {
                                    vkTrack.click("parent_pc_consult_click_button_un")
                                }),
                            (0, o.
                                default)("#lookDetailBtn").click(function () {
                                    vkTrack.click("parent_pc_signup_click_button_friend_view")
                                }),
                            (0, o.
                                default)("#freePromiseBtn").click(function () {
                                    vkTrack.click("parent_pc_consult_fix_click_ad")
                                }),
                            (0, o.
                                default)("#onLineZxBtn").click(function () {
                                    vkTrack.click("parent_pc_consult_fix_click_button_ad")
                                }),
                            (0, o.
                                default)("#freeVipkidLookDeatilBtn").click(function () {
                                    vkTrack.click("parent_pc_signup_click_button_free_view")
                                })
                        }
                    }).init()
                })
    },
    74: function (e, t) { },
    75: function (e, t, i) {
        "use strict";
        var n = i(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(n); (0, a.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.homeBannerBox(),
                                    this.registerBanner()
                            },
                        compile: function (e) {
                            for (var t = String.fromCharCode(e.charCodeAt(0) + e.length), i = 1; i < e.length; i++) t += String.fromCharCode(e.charCodeAt(i) + e.charCodeAt(i - 1));
                            return escape(t)
                        },
                        registerBanner: function () {
                            var e = /^1[3-9][0-9]{9}$/,
                                t = this; (0, a.
                                    default)("#jsRegisterBtn").click(function () {
                                        var i = (0, a.
                                            default)("#jsRegisterBox .registeredRightIpt").val();
                                        i && e.test(i) ? (i = t.compile(i), vkTrack.click("parent_pc_signup_click_box"), window.location.href = "/signup?&mobile=" + i) : (0, a.
                                            default)("#jsRegisterBox .error-tips").show()
                                    })
                        },
                        regsiterChange: function (e) {
                            3 === e ? (0, a.
                                default)("#jsRegisterBox .register-con").css({
                                    color:
                                        "#000000"
                                }) :
                                5 === e ? (0, a.
                                    default)("#jsRegisterBox .register-con").css({
                                        color:
                                            "#000000"
                                    }) :
                                    (0, a.
                                        default)("#jsRegisterBox .register-con").css({
                                            color:
                                                "#ffffff"
                                        })
                        },
                        supportCss3: function (e) {
                            var t, i = ["webkit", "Moz", "ms", "o"],
                                n = [],
                                a = document.documentElement.style,
                                o = function (e) {
                                    return e.replace(/-(\w)/g,
                                        function (e, t) {
                                            return t.toUpperCase()
                                        })
                                };
                            for (t in i) n.push(o(i[t] + "-" + e));
                            n.push(o(e));
                            for (t in n) if (n[t] in a) return !0;
                            return !1
                        },
                        homeBannerBox: function () {
                            function e(e) {
                                k ? (o.eq(e).addClass("showbannerAnimation"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbannerAnimation")) : (o.eq(e).addClass("showbanner"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbanner")),
                                    d.find("li").removeClass("current"),
                                    d.find("li").eq(e).addClass("current"),
                                    _ = !0
                            }
                            function t() {
                                s++ ,
                                    s > r - 1 && (s = 0),
                                    f.regsiterChange(s),
                                    i(s)
                            }
                            function i(e) {
                                k ? (o.eq(e).addClass("showbannerAnimation"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbannerAnimation")) : (o.eq(e).addClass("showbanner"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbanner")),
                                    d.find("li").removeClass("current"),
                                    d.find("li").eq(e).addClass("current")
                            }
                            var n = (0, a.
                                default)("#focus-banner"),
                                o = (0, a.
                                    default)("#focus-banner-list li"),
                                c = (0, a.
                                    default)("#focus-banner-listone"),
                                l = (0, a.
                                    default)(".focus-banner-img"),
                                d = (0, a.
                                    default)("#focus-bubble"),
                                r = o.length,
                                s = 0,
                                u = "",
                                f = this,
                                h = void 0,
                                v = void 0,
                                p = void 0,
                                k = void 0;
                            k = this.supportCss3("animation"),
                                window.console.log(k, "isSupportCss");
                            var g = navigator.userAgent; (0, a.
                                default)("ul#focus-banner-list").mouseover(function () {
                                    g.indexOf("iPad") < 0 && clearInterval(u)
                                }).mouseout(function () {
                                    g.indexOf("iPad") < 0 && (clearInterval(u), u = setInterval(function () {
                                        t()
                                    },
                                        4e3))
                                });
                            var m = (0, a.
                                default)(".focus-banner-img").find("img").height();
                            n.height(m),
                                l.height(m);
                            for (var w = 0; w < r; w++) o.eq(w).css("zIndex", r - w),
                                d.append("<li><span></span></li>");
                            d.find("li").eq(0).addClass("current");
                            var _ = !0;
                            d.on("click", "li",
                                function () {
                                    _ && (_ = !1, clearInterval(u), (0, a.
                                        default)(this).addClass("current").siblings().removeClass("current"), s = (0, a.
                                            default)(this).index(), f.regsiterChange(s), e(s))
                                }),
                                u = setInterval(function () {
                                    t()
                                },
                                    4e3),
                                h = "hidden" in document ? "hidden" : "webkitHidden" in document ? "webkitHidden" : "mozHidden" in document ? "mozHidden" : null,
                                v = h.replace(/hidden/i, "visibilitychange"),
                                p = function () {
                                    document[h] ? clearInterval(u) : (clearInterval(u), u = setInterval(function () {
                                        t()
                                    },
                                        4e3))
                                },
                                document.addEventListener(v, p),
                                c.on("click",
                                    function () {
                                        vkTrack.click("parent_pc_signup_click_Banner")
                                    });
                            var b = document.querySelector("#focus-banner-list"),
                                C = (0, a.
                                    default)("#focus-banner").width(),
                                B = 0,
                                x = 0,
                                y = 0,
                                T = !1;
                            b.addEventListener("touchstart",
                                function (e) {
                                    clearInterval(u),
                                        B = e.touches[0].clientX
                                }),
                                b.addEventListener("touchmove",
                                    function (e) {
                                        x = e.touches[0].clientX,
                                            y = x - B,
                                            T = !0
                                    }),
                                b.addEventListener("touchend",
                                    function () {
                                        T && Math.abs(y) > C / 5 && (y > 0 ? s-- : s++ , T = !1),
                                            s > r - 1 ? s = 0 : s < 0 && (s = r - 1),
                                            f.regsiterChange(s),
                                            i(s)
                                    })
                        }
                    }).init()
                })
    }
},
    [73]);