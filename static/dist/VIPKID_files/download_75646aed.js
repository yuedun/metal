webpackJsonp([5], {
    1: function (e, t, n) {
        "use strict";
        var i = n(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(i); (0, a.
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
                            if (- 1 != e.indexOf("?")) for (var n = e.substr(1), i = n.split("&"), a = 0; a < i.length; a++) t[i[a].split("=")[0]] = decodeURI(i[a].split("=")[1]);
                            return t
                        },
                        skip: function () {
                            var e = {};
                            if (window.location.search.substr(1).split("&").forEach(function (t) {
                                var n = t.split("=");
                                e[n[0]] = n[1]
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
    2: function (e, t, n) {
        "use strict";
        var i = n(0); (0,
            function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(i).
                default)(function () {
                    ({
                        init:
                            function () { }
                    }).init()
                })
    },
    3: function (e, t, n) {
        "use strict";
        var i = n(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(i); (0, a.
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
    4: function (e, t, n) {
        "use strict";
        var i = n(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(i); (0, a.
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
                            for (var t = String.fromCharCode(e.charCodeAt(0) + e.length), n = 1; n < e.length; n++) t += String.fromCharCode(e.charCodeAt(n) + e.charCodeAt(n - 1));
                            return escape(t)
                        },
                        IsPcPage: function () {
                            var e = 0,
                                t = navigator.userAgent,
                                n = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"],
                                i = !0;
                            for (this.isPcBox = !0, e = 0; e < n.length; e++) if (t.indexOf(n[e]) > 0) {
                                i = !1,
                                    this.isPcBox = !1;
                                break
                            }
                            return i
                        },
                        httpClickRegisterAuditions: function () {
                            var e = /^1[3-9][0-9]{9}$/,
                                t = this; (0, a.
                                    default)("#fixClickBottomBtn").click(function () {
                                        var n = (0, a.
                                            default)(".registerAuditions").val();
                                        n && e.test(n) ? (n = t.compile(n), vkTrack.click("parent_pc_bottom_signup_click_box"), location.href = "/signup?&mobile=" + n) : (0, a.
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
    66: function (e, t, n) {
        "use strict";
        n(67),
            n(1),
            n(68),
            n(3),
            n(2),
            n(4);
        var i = n(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(i); (0, a.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.httpGetDownload(),
                                    this.eventClickTrackDownload()
                            },
                        httpGetDownload: function () {
                            a.
                                default.ajax({
                                    url:
                                        "/posts/productions/1.json",
                                    success: function (e) {
                                        var t = e[1] || [],
                                            n = e[2] || [],
                                            i = "",
                                            o = ""; (0, a.
                                                default)(t).each(function (e, t) {
                                                    i += '<li class="col_6"><div class="qrcode clearfix product-qrcode"><div class="qrcode-img product-qrcode-img"><img src="' + t.icon + '"><p>微信扫描体验</p></div><div class="qrcode-desc"><h3>' + t.name + "</h3><p>" + t.description + "</p></div></div></li> "
                                                }),
                                                (0, a.
                                                    default)(n).each(function (e, t) {
                                                        o += '<li class="col_6"><div class="qrcode clearfix"><div class="qrcode-img"><img src="' + t.icon + '"></div><div class="qrcode-desc"><h3>' + t.name + "</h3><p>" + t.description + '</p></div><div class="btn-download">',
                                                            (0, a.
                                                                default)(t.versions).each(function (e, t) {
                                                                    o += '<a href="' + t.url + '">' + t.platform + "下载</a>"
                                                                }),
                                                            o += "</div></div></li>"
                                                    }),
                                                (0, a.
                                                    default)(".recommend-product ul.product-list").html(i),
                                                (0, a.
                                                    default)(".recommend-software ul.software-list").html(o)
                                    }
                                })
                        },
                        eventClickTrackDownload: function () {
                            (0, a.
                                default)("#androidDownloadBtn").click(function () {
                                    vkTrack.click("parent_pc_Androiddownload_click")
                                }),
                            (0, a.
                                default)("#ipadDownloadBtn").click(function () {
                                    vkTrack.click("parent_pc_iPaddownload_click")
                                }),
                            (0, a.
                                default)("#macDownloadBtn").click(function () {
                                    vkTrack.click("parent_pc_Macdownload_click")
                                }),
                            (0, a.
                                default)("#windowDownloadBtn").click(function () {
                                    vkTrack.click("parent_pc_Windowsdownload_click")
                                }),
                            (0, a.
                                default)("#ahoversLink").click(function () {
                                    vkTrack.click("parent_pc_Learnmore_click")
                                })
                        }
                    }).init()
                })
    },
    67: function (e, t) { },
    68: function (e, t, n) {
        "use strict";
        var i = n(0),
            a = function (e) {
                return e && e.__esModule ? e : {
                    default:
                        e
                }
            }(i); (0, a.
                default)(function () {
                    ({
                        init:
                            function () {
                                this.downloadBannerBox()
                            },
                        supportCss3: function (e) {
                            var t, n = ["webkit", "Moz", "ms", "o"],
                                i = [],
                                a = document.documentElement.style,
                                o = function (e) {
                                    return e.replace(/-(\w)/g,
                                        function (e, t) {
                                            return t.toUpperCase()
                                        })
                                };
                            for (t in n) i.push(o(n[t] + "-" + e));
                            i.push(o(e));
                            for (t in i) if (i[t] in a) return !0;
                            return !1
                        },
                        downloadBannerBox: function () {
                            function e(e) {
                                v ? (o.eq(e).addClass("showbannerAnimation"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbannerAnimation")) : (o.eq(e).addClass("showbanner"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbanner")),
                                    l.find("li").removeClass("current"),
                                    l.find("li").eq(e).addClass("current"),
                                    m = !0
                            }
                            function t() {
                                s++ ,
                                    s > d - 1 && (s = 0),
                                    n(s)
                            }
                            function n(e) {
                                v ? (o.eq(e).addClass("showbannerAnimation"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbannerAnimation")) : (o.eq(e).addClass("showbanner"), o.eq(e).siblings().addClass("hidebanner").removeClass("showbanner")),
                                    l.find("li").removeClass("current"),
                                    l.find("li").eq(e).addClass("current")
                            }
                            var i = (0, a.
                                default)("#focus-banner"),
                                o = (0, a.
                                    default)("#focus-banner-list li"),
                                c = (0, a.
                                    default)(".focus-banner-img"),
                                l = (0, a.
                                    default)("#focus-bubble"),
                                d = o.length,
                                s = 0,
                                r = "",
                                u = void 0,
                                f = void 0,
                                h = void 0,
                                v = void 0;
                            v = this.supportCss3("animation");
                            var k = navigator.userAgent; (0, a.
                                default)("ul#focus-banner-list").mouseover(function () {
                                    k.indexOf("iPad") < 0 && clearInterval(r)
                                }).mouseout(function () {
                                    k.indexOf("iPad") < 0 && (clearInterval(r), r = setInterval(function () {
                                        t()
                                    },
                                        4e3))
                                });
                            var p = (0, a.
                                default)(".focus-banner-img").find("img").height();
                            i.height(p),
                                c.height(p);
                            for (var g = 0; g < d; g++) o.eq(g).css("zIndex", d - g),
                                l.append("<li><span></span></li>");
                            l.find("li").eq(0).addClass("current");
                            var m = !0;
                            l.on("click", "li",
                                function () {
                                    m && (m = !1, clearInterval(r), (0, a.
                                        default)(this).addClass("current").siblings().removeClass("current"), s = (0, a.
                                            default)(this).index(), e(s))
                                }),
                                clearInterval(r),
                                r = setInterval(function () {
                                    t()
                                },
                                    4e3),
                                u = "hidden" in document ? "hidden" : "webkitHidden" in document ? "webkitHidden" : "mozHidden" in document ? "mozHidden" : null,
                                f = u.replace(/hidden/i, "visibilitychange"),
                                h = function () {
                                    document[u] ? clearInterval(r) : (clearInterval(r), r = setInterval(function () {
                                        t()
                                    },
                                        4e3))
                                },
                                document.addEventListener(f, h);
                            var w = document.querySelector("#focus-banner-list"),
                                C = (0, a.
                                    default)("#focus-banner").width(),
                                b = 0,
                                _ = 0,
                                B = 0,
                                x = !1;
                            w.addEventListener("touchstart",
                                function (e) {
                                    clearInterval(r),
                                        b = e.touches[0].clientX
                                }),
                                w.addEventListener("touchmove",
                                    function (e) {
                                        _ = e.touches[0].clientX,
                                            B = _ - b,
                                            x = !0
                                    }),
                                w.addEventListener("touchend",
                                    function () {
                                        x && Math.abs(B) > C / 5 && (B > 0 ? s-- : s++ , x = !1),
                                            s > d - 1 ? s = 0 : s < 0 && (s = d - 1),
                                            n(s)
                                    })
                        }
                    }).init()
                })
    }
},
    [66]);