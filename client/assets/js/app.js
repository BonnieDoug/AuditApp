(function () {
    'use strict';
    angular.module('application', [
        'ui.router',
        'angular-toArrayFilter',
//        'ngRoute',
//        'ui-select',
        'as.sortable',
        'ngAria',
        'ngMaterial',
        'ngAnimate',
        'ngMessages',
        'foundation',
        'foundation.dynamicRouting.animations',
        'ncy-angular-breadcrumb',
        'angularUtils.directives.dirPagination',
        'ngFileUpload'
        
    ])
            .config(config)
            .run(run)
            ;
    config.$inject = ['$stateProvider', '$urlRouterProvider', 'paginationTemplateProvider'];

    function config($stateProvider, $urlRouterProvider, paginationTemplateProvider) {
        paginationTemplateProvider.setPath('templates/includes/pagination.html');
        $stateProvider
                .state('home', {
                    url: '/',
                    templateUrl: 'templates/home.html',
                    authenticate: true,
                    ncyBreadcrumb: {
                        label: 'Home page'
                    }
                })
                .state('login', {
                    url: 'login/',
                    parent: 'account',
                    templateUrl: 'templates/login.html',
                    controller: 'AuthController',
                    authenticate: false,
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
                    authenticate: true,
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
                    authenticate: true,
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
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Account Settings'
                    }
                })
                .state('auditcp', {
                    parent: 'home',
                    url: 'control-panel/',
                    templateUrl: 'templates/audit/index.html',
                    controller: 'AuditController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Audit Control Panel'
                    }
                })
                .state('audit-view', {
                    url: 'audit-view/:anauditid',
                    parent: 'auditcp',
                    controller: 'AuditController',
                    templateUrl: 'templates/audit/view.html',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'View Audit'
                    }
                })
                .state('take-audit', {
                    url: 'take-audit/:anauditid',
                    parent: 'auditcp',
                    controller: 'AuditController',
                    templateUrl: 'templates/audit/takeaudit.html',
                    authenticate: true,
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
                    authenticate: true,
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
                    authenticate: true,
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
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Create Audit'
                    }
                })
                .state('asset-new', {
                    url: 'New',
                    parent: 'assets-index',
                    templateUrl: 'templates/assets/new.html',
                    controller: 'AssetController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Create Asset'
                    }
                })
                .state('assets-all', {
                    url: 'all/',
                    parent: 'assets-index',
                    templateUrl: 'templates/assets/assets-all.html',
                    controller: 'AssetController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'All Assets'
                    }
                })
                .state('assets-index', {
                    url: 'asset-manager/',
                    parent: 'home',
                    templateUrl: 'templates/assets/index.html',
                    controller: 'AssetController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Asset Groups'
                    }
                })
                .state('asset-types', {
                    url: ':asgrtype/:asgrid',
                    parent: 'assets-index',
                    templateUrl: 'templates/assets/types.html',
                    controller: 'AssetController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: '{{ grname }}'
                    }
                })
                .state('asset-all-by-type', {
                    url: '/all',
                    parent: 'asset-types',
                    templateUrl: 'templates/assets/assets-by-group.html',
                    controller: 'AssetController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'All'
                    }
                })
                .state('asset-by-type', {
                    url: '/:astytype/:astyid',
                    parent: 'asset-types',
                    templateUrl: 'templates/assets/assets-by-type.html',
                    controller: 'AssetController',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: '{{ tyname }}'
                    }
                })
                .state('reporting-index', {
                    url: 'reporting-suite/',
                    parent: 'home',
                    templateUrl: 'templates/reporting/index.html',
                    authenticate: true,
                    resolve: {
                    },
                    ncyBreadcrumb: {
                        label: 'Reporting Suite'
                    }
                })
                ;
        $stateProvider.state("otherwise", {
            url: "not-found*path",
            templateUrl: "templates/error/404.html"
        });
        
        
        
    }

    function run() {
        FastClick.attach(document.body);
    }

})();

angular.module("application").run(function ($rootScope, $state, AuthChecker) {
  $rootScope.$on("$stateChangeStart", function(event, toState, toParams, fromState, fromParams){
    if (toState.authenticate && !AuthChecker.isAuthed()){
      // User isn’t authenticated
      $state.go('login', {}, {reload: true});
      event.preventDefault(); 
    }
  });
});

