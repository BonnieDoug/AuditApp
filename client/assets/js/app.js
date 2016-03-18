(function () {
    'use strict';
    angular.module('application', [
        'ui.router',
//        'ngRoute',
        'ngAria',
        'ngMaterial',
        'ngAnimate',
        'foundation',
        'foundation.dynamicRouting.animations',
        'ncy-angular-breadcrumb'
    ])
            .config(config)
            .run(run)
            ;
    config.$inject = ['$stateProvider', '$urlRouterProvider'];

    function config($stateProvider, $urlRouterProvider) {

        $stateProvider
                .state('home', {
                    url: '/',
                    templateUrl: 'templates/home.html',
                    ncyBreadcrumb: {
                        label: 'Home page'
                    }
                })
                .state('login', {
                    url: 'login/',
                    parent: 'account',
                    templateUrl: 'templates/login.html',
                    controller: 'AuthController',
                    animation: {
                        enter: 'slideInDown',
                        leave: 'slideOutDown'
                    },
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Login'
                    }
                })
                .state('account', {
                    parent: 'home',
                    url: 'account/',
                    templateUrl: 'templates/account.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Your Account'
                    }
                })
                .state('forgotten-password', {
                    url: 'forgotten-password/',
                    parent: 'account',
                    templateUrl: 'templates/forgot-password.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Forgotten Password'
                    }
                })

                .state('settings', {
                    parent: 'home',
                    url: 'settings/',
                    templateUrl: 'templates/settings.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Settings'
                    }
                })
                .state('auditcp', {
                    parent: 'home',
                    url: 'control-panel/',
                    templateUrl: 'templates/audit/index.html',
                    controller: 'AuditController',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Control Panel'
                    }
                })
                .state('audit-view', {
                    url: 'audit-view/',
                    parent: 'auditcp',
                    templateUrl: 'templates/audit/view.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'View Audit'
                    }
                })
                .state('take-audit', {
                    url: 'take-audit/',
                    parent: 'auditcp',
                    templateUrl: 'templates/audit/takeaudit.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Take Audit'
                    }
                })
                .state('audit-delete', {
                    url: 'audit-delete/',
                    parent: 'audit-view',
                    templateUrl: 'templates/audit/delete.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Delete Audit'
                    }
                })
                .state('audit-update', {
                    url: 'audit-update/:anauditid',
                    parent: 'audit-view',
                    controller: 'AuditController',
                    templateUrl: 'templates/audit/update.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Update Audit'
                    }
                })
                .state('audit-new', {
                    url: 'audit-new/',
                    parent: 'auditcp',
                    templateUrl: 'templates/audit/new.html',
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Create Audit'
                    }
                })
                ;
        $stateProvider.state("otherwise", {
            url: "*path",
            templateUrl: "templates/error/404.html"
        });
    }

    function run() {
        FastClick.attach(document.body);
    }

})();

