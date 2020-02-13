webpackJsonp([3], {
    1: function (t, e, i) {
        "use strict";
        var n = i(0),
            o = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(n); (0, o.
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
                            (0, o.
                                default)("#registerHeaderBtn,#padRegisterHeaderBtn").on("click",
                                    function () {
                                        vkTrack.click("parent_pc_signup_click_head"),
                                            window.location.href = "/signup"
                                    })
                        },
                        loginJump: function () {
                            (0, o.
                                default)("#loginHeaderBtn,#padLoginHeaderBtn").on("click",
                                    function () {
                                        vkTrack.click("parent_pc_login_click_head"),
                                            window.location.href = "/login"
                                    })
                        },
                        padMenu: function () {
                            (0, o.
                                default)("#systemMenu").click(function () {
                                    (0, o.
                                        default)("#systemMenu .menu-box").toggle()
                                })
                        },
                        eventClick: function () {
                            var t = !0; (0, o.
                                default)("#navBtn").on("click",
                                    function () {
                                        t ? ((0, o.
                                            default)("body,html").css("overflow", "hidden"), (0, o.
                                                default)("body").addClass("active"), (0, o.
                                                    default)("#navLiderLeft").addClass("sliderbarShow"), t = !1) : ((0, o.
                                                        default)("body,html").css("overflow", "auto"), (0, o.
                                                            default)("body").removeClass("active"), (0, o.
                                                                default)("#navLiderLeft").removeClass("sliderbarShow"), t = !0)
                                    })
                        },
                        getRequest: function () {
                            var t = window.location.search,
                                e = new Object;
                            if (- 1 != t.indexOf("?")) for (var i = t.substr(1), n = i.split("&"), o = 0; o < n.length; o++) e[n[o].split("=")[0]] = decodeURI(n[o].split("=")[1]);
                            return e
                        },
                        skip: function () {
                            var t = {};
                            if (window.location.search.substr(1).split("&").forEach(function (e) {
                                var i = e.split("=");
                                t[i[0]] = i[1]
                            }), t.hasOwnProperty("channel_id")) {
                                var e = t.channel_id; (0, o.
                                    default)(".header-info-pc a, .header-info-ipad a").each(function () {
                                        var t = (0, o.
                                            default)(this).attr("href"); (0, o.
                                                default)(this).attr("href", t + "?channel_id=" + e)
                                    })
                            }
                        },
                        eventClickToggleNavigation: function () {
                            var t = window.location.pathname;
                            if (t.length <= 1) return void (0, o.
                                default)(".sy").addClass("active");
                            switch (t = t.split("/")[2]) {
                                case "home":
                                    (0, o.
                                        default)(".sy").addClass("active");
                                    break;
                                case "teachers":
                                    (0, o.
                                        default)(".bmsz").addClass("active");
                                    break;
                                case "advantage":
                                    (0, o.
                                        default)(".kctx").addClass("active"),
                                        (0, o.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, o.
                                            default)(".kctxys").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "mc":
                                    (0, o.
                                        default)(".kctx").addClass("active"),
                                        (0, o.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, o.
                                            default)(".zxk").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "vae":
                                    (0, o.
                                        default)(".kctx").addClass("active"),
                                        (0, o.
                                            default)(".menu-box a").css("font-weight", "400"),
                                        (0, o.
                                            default)(".qxjjkc").css({
                                                color:
                                                    "#F85415",
                                                "font-weight": "600"
                                            });
                                    break;
                                case "classlist":
                                    (0, o.
                                        default)(".gkk").addClass("active");
                                    break;
                                case "step":
                                    (0, o.
                                        default)(".rhsk").addClass("active");
                                    break;
                                case "download":
                                    (0, o.
                                        default)(".xzzx").addClass("active");
                                    break;
                                case "aboutus":
                                case "news":
                                    (0, o.
                                        default)(".zxdt").addClass("active")
                            }
                        }
                    }).init()
                })
    },
    2: function (t, e, i) {
        "use strict";
        var n = i(0); (0,
            function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(n).
                default)(function () {
                    ({
                        init:
                            function () { }
                    }).init()
                })
    },
    3: function (t, e, i) {
        "use strict";
        var n = i(0),
            o = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(n); (0, o.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.eventChange(),
                                    this.eventClickVktrackFooterSecond()
                            },
                        eventChange: function () {
                            (0, o.
                                default)("#goToWeibo").click(function () {
                                    window.location.href = "http://weibo.com/p/1006065212940492"
                                })
                        },
                        eventClickVktrackFooterSecond: function () {
                            (0, o.
                                default)("#onlineZxFooterBtn").click(function () {
                                    vkTrack.click("parent_pc_footer_consult_box")
                                })
                        }
                    }).init()
                })
    },
    4: function (t, e, i) {
        "use strict";
        var n = i(0),
            o = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(n); (0, o.
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
                            (0, o.
                                default)("#goBackBtn").click(function () {
                                    return (0, o.
                                        default)("html,body").animate({
                                            scrollTop:
                                                0
                                        },
                                            1e3),
                                        !1
                                })
                        },
                        scrollScreenHeight: function () {
                            (0, o.
                                default)(window).scroll(function () {
                                    (0, o.
                                        default)(window).scrollTop() >= .5 * (0, o.
                                            default)(window).height() && !t ? ((0, o.
                                                default)("#sectionBottom").addClass("active"), (0, o.
                                                    default)("#sectionBottom").removeClass("hideB"), (0, o.
                                                        default)("#goBackBtn").show()) :
                                    ((0, o.
                                        default)("#sectionBottom").removeClass("active"), (0, o.
                                            default)("#sectionBottom").addClass("hideB"), (0, o.
                                                default)("#goBackBtn").hide()),
                                    (0, o.
                                        default)(window).scrollTop() >= .5 * (0, o.
                                            default)(window).height() ? (0, o.
                                                default)("#goBackBtn").show() :
                                        (0, o.
                                            default)("#goBackBtn").hide(),
                                    (0, o.
                                        default)(window).scrollTop() + (0, o.
                                            default)(window).height() >= (0, o.
                                                default)(document).height() - (0, o.
                                                    default)(".footer").height() && ((0, o.
                                                        default)("#sectionBottom").removeClass("active"), (0, o.
                                                            default)("#sectionBottom").addClass("hideB"), (0, o.
                                                                default)("#goBackBtn").show())
                                })
                        },
                        compile: function (t) {
                            for (var e = String.fromCharCode(t.charCodeAt(0) + t.length), i = 1; i < t.length; i++) e += String.fromCharCode(t.charCodeAt(i) + t.charCodeAt(i - 1));
                            return escape(e)
                        },
                        IsPcPage: function () {
                            var t = 0,
                                e = navigator.userAgent,
                                i = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"],
                                n = !0;
                            for (this.isPcBox = !0, t = 0; t < i.length; t++) if (e.indexOf(i[t]) > 0) {
                                n = !1,
                                    this.isPcBox = !1;
                                break
                            }
                            return n
                        },
                        httpClickRegisterAuditions: function () {
                            var t = /^1[3-9][0-9]{9}$/,
                                e = this; (0, o.
                                    default)("#fixClickBottomBtn").click(function () {
                                        var i = (0, o.
                                            default)(".registerAuditions").val();
                                        i && t.test(i) ? (i = e.compile(i), vkTrack.click("parent_pc_bottom_signup_click_box"), location.href = "/signup?&mobile=" + i) : (0, o.
                                            default)("#bottomErrorTips").show()
                                    }),
                                    (0, o.
                                        default)("#fixRightBtn").click(function () {
                                            vkTrack.click("parent_pc_consult_fix_click_th")
                                        })
                        },
                        eventClickToggleRightFix: function () {
                            (0, o.
                                default)("#qrcodeTouchBtn").on("touchend",
                                    function () {
                                        (0, o.
                                            default)("#erweima").toggle()
                                    }),
                            (0, o.
                                default)("#telTouchBtn").on("touchend",
                                    function () {
                                        (0, o.
                                            default)("#teltips").toggle()
                                    })
                        },
                        eventClickCloseBottom: function () {
                            (0, o.
                                default)("#closeBtnBottom").click(function () {
                                    t = !0,
                                        vkTrack.click("parent_pc_bottom_signup_click_close"),
                                        (0, o.
                                            default)("#sectionBottom").removeClass("active"),
                                        (0, o.
                                            default)("#sectionBottom").addClass("hideB")
                                })
                        }
                    }).init()
                })
    },
    92: function (t, e, i) {
        "use strict";
        i(93),
            i(1),
            i(94),
            i(3),
            i(2),
            i(4);
        var n = i(0),
            o = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(n); (0, o.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.eventClickVktrackTeachers()
                            },
                        eventClickVktrackTeachers: function () {
                            (0, o.
                                default)("#freeClassTeachersBtn").click(function () {
                                    vkTrack.click("parent_pc_signup_click_beimeishizi_f"),
                                        window.location.href = "/signup"
                                })
                        }
                    }).init()
                })
    },
    93: function (t, e) { },
    94: function (t, e, i) {
        "use strict";
        var n = i(0),
            o = function (t) {
                return t && t.__esModule ? t : {
                    default:
                        t
                }
            }(n); (0, o.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.teachersBannerBox()
                            },
                        getStyle: function (t, e) {
                            return window.getComputedStyle ? window.getComputedStyle(t, null)[e] : t.currentStyle[e]
                        },
                        animate: function (t, e, i) {
                            var n = this;
                            clearInterval(t.timer),
                                t.timer = setInterval(function () {
                                    var o = !0;
                                    for (var a in e) {
                                        var c = a,
                                            l = e[a];
                                        if ("class" == a) t.className = l;
                                        else if ("zIndex" == a) t.style.zIndex = l;
                                        else if ("opacity" == a) {
                                            var s = n.getStyle(t, c);
                                            s = parseFloat(s) || 0,
                                                s *= 1e3,
                                                l *= 1e3;
                                            var d = (l - s) / 10;
                                            d = d > 0 ? Math.ceil(d) : Math.floor(d),
                                                s += d,
                                                t.style[c] = s / 1e3,
                                                s != l && (o = !1)
                                        } else if ("height" == a) t.style.height = l + "px";
                                        else {
                                            var r = n.getStyle(t, c);
                                            r = parseInt(r) || 0;
                                            var u = l - r;
                                            u = u > 0 ? Math.ceil(u) : Math.floor(u),
                                                r += u,
                                                t.style[c] = r + "px",
                                                r != l && (o = !1)
                                        }
                                    }
                                    o && (clearInterval(t.timer), i && i())
                                },
                                    20)
                        },
                        teachersBannerBox: function () {
                            for (var t = this,
                                e = [{
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 20,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 290,
                                    top: 110,
                                    left: 20,
                                    opacity: .8,
                                    zIndex: 2,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 420,
                                    top: 0,
                                    left: 302,
                                    opacity: 1,
                                    zIndex: 4,
                                    height: 500,
                                    class: "middle"
                                },
                                {
                                    width: 290,
                                    top: 110,
                                    left: 710,
                                    opacity: .8,
                                    zIndex: 2,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                },
                                {
                                    width: 200,
                                    top: 110,
                                    left: 710,
                                    opacity: 0,
                                    zIndex: 1,
                                    height: 280,
                                    class: "other"
                                }], i = document.getElementById("wrap"), n = document.getElementById("slide"), a = n.getElementsByTagName("li"), c = document.getElementById("arrow"), l = document.getElementById("arrLeft"), s = document.getElementById("arrRight"), d = !0, r = "", u = 0; u < a.length; u++) t.animate(a[u], e[u]);
                            i.onmouseover = function () {
                                t.animate(c, {
                                    opacity: 1
                                })
                            },
                                i.onmouseout = function () {
                                    t.animate(c, {
                                        opacity: 0
                                    })
                                },
                                s.onclick = function () {
                                    if (d) {
                                        d = !1,
                                            e.unshift(e.pop());
                                        for (var i = 0; i < a.length; i++) t.animate(a[i], e[i],
                                            function () {
                                                d = !0
                                            });
                                        clearInterval(r),
                                            r = setInterval(function () {
                                                l.click()
                                            },
                                                4e3)
                                    }
                                },
                                l.onclick = function () {
                                    e.push(e.shift());
                                    for (var i = 0; i < a.length; i++) t.animate(a[i], e[i]);
                                    clearInterval(r),
                                        r = setInterval(function () {
                                            l.click()
                                        },
                                            4e3)
                                },
                                document.onvisibilitychange = function () {
                                    "visible" == document.visibilityState ? r = setInterval(function () {
                                        l.click()
                                    },
                                        4e3) : clearInterval(r)
                                };
                            var f = document.getElementById("slide"),
                                h = (0, o.
                                    default)("#slide").width(),
                                g = 0,
                                p = 0,
                                v = 0,
                                k = !1;
                            f.addEventListener("touchstart",
                                function (t) {
                                    clearInterval(r),
                                        g = t.touches[0].clientX
                                }),
                                f.addEventListener("touchmove",
                                    function (t) {
                                        p = t.touches[0].clientX,
                                            v = p - g,
                                            k = !0
                                    }),
                                f.addEventListener("touchend",
                                    function () {
                                        k && Math.abs(v) > h / 5 && (v > 0 ? l.click() : s.click(), k = !1)
                                    })
                        }
                    }).init()
                })
    }
},
    [92]);