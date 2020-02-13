webpackJsonp([19], {
    1: function (t, e, a) {
        "use strict";
        var i = a(0),
            n = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(i); (0, n.
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
                            (0, n.
                                default)("#registerHeaderBtn,#padRegisterHeaderBtn").on("click",
                                    function () {
                                        vkTrack.click("parent_pc_signup_click_head"),
                                            window.location.href = "/signup"
                                    })
                        },
                        loginJump: function () {
                            (0, n.
                                default)("#loginHeaderBtn,#padLoginHeaderBtn").on("click",
                                    function () {
                                        vkTrack.click("parent_pc_login_click_head"),
                                            window.location.href = "/login"
                                    })
                        },
                        padMenu: function () {
                            (0, n.
                                default)("#systemMenu").click(function () {
                                    (0, n.
                                        default)("#systemMenu .menu-box").toggle()
                                })
                        },
                        eventClick: function () {
                            var t = !0; (0, n.
                                default)("#navBtn").on("click",
                                    function () {
                                        t ? ((0, n.
                                            default)("body,html").css("overflow", "hidden"), (0, n.
                                                default)("body").addClass("active"), (0, n.
                                                    default)("#navLiderLeft").addClass("sliderbarShow"), t = !1) : ((0, n.
                                                        default)("body,html").css("overflow", "auto"), (0, n.
                                                            default)("body").removeClass("active"), (0, n.
                                                                default)("#navLiderLeft").removeClass("sliderbarShow"), t = !0)
                                    })
                        },
                        getRequest: function () {
                            var t = window.location.search,
                                e = new Object;
                            if (- 1 != t.indexOf("?")) for (var a = t.substr(1), i = a.split("&"), n = 0; n < i.length; n++) e[i[n].split("=")[0]] = decodeURI(i[n].split("=")[1]);
                            return e
                        },
                        skip: function () {
                            var t = {};
                            if (window.location.search.substr(1).split("&").forEach(function (e) {
                                var a = e.split("=");
                                t[a[0]] = a[1]
                            }), t.hasOwnProperty("channel_id")) {
                                var e = t.channel_id; (0, n.
                                    default)(".header-info-pc a, .header-info-ipad a").each(function () {
                                        var t = (0, n.
                                            default)(this).attr("href"); (0, n.
                                                default)(this).attr("href", t + "?channel_id=" + e)
                                    })
                            }
                        },
                        eventClickToggleNavigation: function () {
                            var t = window.location.pathname;
                            if (t.length <= 1) return void (0, n.
                                default)(".sy").addClass("active");
                            switch (t = t.split("/")[2]) {
                                case "home":
                                    (0, n.
                                        default)(".sy").addClass("active");
                                    break;
                                case "teachers":
                                    (0, n.
                                        default)(".bmsz").addClass("active");
                                    break;
                                case "advantage":
                                    (0, n.
                                        default)(".kctx").addClass("active"),
                                        (0, n.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, n.
                                            default)(".kctxys").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "mc":
                                    (0, n.
                                        default)(".kctx").addClass("active"),
                                        (0, n.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, n.
                                            default)(".zxk").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "vae":
                                    (0, n.
                                        default)(".kctx").addClass("active"),
                                        (0, n.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, n.
                                            default)(".qxjjkc").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "classlist":
                                    (0, n.
                                        default)(".gkk").addClass("active");
                                    break;
                                case "step":
                                    (0, n.
                                        default)(".rhsk").addClass("active");
                                    break;
                                case "download":
                                    (0, n.
                                        default)(".xzzx").addClass("active");
                                    break;
                                case "aboutus":
                                case "news":
                                    (0, n.
                                        default)(".zxdt").addClass("active")
                            }
                        }
                    }).init()
                })
    },
    4: function (t, e, a) {
        "use strict";
        var i = a(0),
            n = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(i); (0, n.
                default)(function () {
                    var t = !1; ({
                        init: function () {
                            this.scrollScreenHeight(),
                                this.httpClickRegisterAuditions(),
                                this.goBackTop(),
                                this.eventClickToggleRightFix(),
                                this.eventClickCloseBottom()
                        },
                        goBackTop: function () {
                            (0, n.
                                default)("#goBackBtn").click(function () {
                                    return (0, n.
                                        default)("html,body").animate({
                                            scrollTop:
                                                0
                                        },
                                            1e3),
                                        !1
                                })
                        },
                        scrollScreenHeight: function () {
                            (0, n.
                                default)(window).scroll(function () {
                                    (0, n.
                                        default)(window).scrollTop() >= .5 * (0, n.
                                            default)(window).height() && !t ? ((0, n.
                                                default)("#sectionBottom").addClass("active"), (0, n.
                                                    default)("#sectionBottom").removeClass("hideB"), (0, n.
                                                        default)("#goBackBtn").show()) :
                                    ((0, n.
                                        default)("#sectionBottom").removeClass("active"), (0, n.
                                            default)("#sectionBottom").addClass("hideB"), (0, n.
                                                default)("#goBackBtn").hide()),
                                    (0, n.
                                        default)(window).scrollTop() >= .5 * (0, n.
                                            default)(window).height() ? (0, n.
                                                default)("#goBackBtn").show() :
                                        (0, n.
                                            default)("#goBackBtn").hide(),
                                    (0, n.
                                        default)(window).scrollTop() + (0, n.
                                            default)(window).height() >= (0, n.
                                                default)(document).height() - (0, n.
                                                    default)(".footer").height() && ((0, n.
                                                        default)("#sectionBottom").removeClass("active"), (0, n.
                                                            default)("#sectionBottom").addClass("hideB"), (0, n.
                                                                default)("#goBackBtn").show())
                                })
                        },
                        compile: function (t) {
                            for (var e = String.fromCharCode(t.charCodeAt(0) + t.length), a = 1; a < t.length; a++) e += String.fromCharCode(t.charCodeAt(a) + t.charCodeAt(a - 1));
                            return escape(e)
                        },
                        IsPcPage: function () {
                            var t = 0,
                                e = navigator.userAgent,
                                a = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"],
                                i = !0;
                            for (this.isPcBox = !0, t = 0; t < a.length; t++) if (e.indexOf(a[t]) > 0) {
                                i = !1,
                                    this.isPcBox = !1;
                                break
                            }
                            return i
                        },
                        httpClickRegisterAuditions: function () {
                            var t = /^1[3-9][0-9]{9}$/,
                                e = this; (0, n.
                                    default)("#fixClickBottomBtn").click(function () {
                                        var a = (0, n.
                                            default)(".registerAuditions").val();
                                        a && t.test(a) ? (a = e.compile(a), vkTrack.click("parent_pc_bottom_signup_click_box"), location.href = "/signup?&mobile=" + a) : (0, n.
                                            default)("#bottomErrorTips").show()
                                    }),
                                    (0, n.
                                        default)("#fixRightBtn").click(function () {
                                            vkTrack.click("parent_pc_consult_fix_click_th")
                                        })
                        },
                        eventClickToggleRightFix: function () {
                            (0, n.
                                default)("#qrcodeTouchBtn").on("touchend",
                                    function () {
                                        (0, n.
                                            default)("#erweima").toggle()
                                    }),
                            (0, n.
                                default)("#telTouchBtn").on("touchend",
                                    function () {
                                        (0, n.
                                            default)("#teltips").toggle()
                                    })
                        },
                        eventClickCloseBottom: function () {
                            (0, n.
                                default)("#closeBtnBottom").click(function () {
                                    t = !0,
                                        vkTrack.click("parent_pc_bottom_signup_click_close"),
                                        (0, n.
                                            default)("#sectionBottom").removeClass("active"),
                                        (0, n.
                                            default)("#sectionBottom").addClass("hideB")
                                })
                        }
                    }).init()
                })
    },
    53: function (t, e, a) {
        "use strict";
        a(54),
            a(1),
            a(4);
        var i = a(0),
            n = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(i); (0, n.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.eventClickVktrackAdvantage()
                            },
                        eventClickVktrackAdvantage: function () {
                            (0, n.
                                default)("#freeSystemClassBtn").click(function () {
                                    vkTrack.click("parent_pc_signup_click_body_box_advantage_f"),
                                        window.location.href = "/signup"
                                }),
                            (0, n.
                                default)("#freeInternationalClassBtn").click(function () {
                                    vkTrack.click("parent_pc_signup_click_body_box_advantage_s"),
                                        window.location.href = "/signup"
                                })
                        }
                    }).init()
                })
    },
    54: function (t, e) { }
},
    [53]);