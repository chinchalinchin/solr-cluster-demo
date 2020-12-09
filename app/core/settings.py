import os

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# APPLICATION CONFIGURATION
APP_ENV = os.environ.setdefault('APP_ENV','local')
SECRET_KEY = os.environ.setdefault('SECRET_KEY', 'xxxx')
ROOT_URLCONF = 'core.urls'
WSGI_APPLICATION = 'core.wsgi.application'

### ENVIRONMENT SPECIFIC CONFIGURATION ###
# DEBUG CONFIGURATION
if APP_ENV == 'local':
    DEBUG=True
    VERBOSE=False
elif APP_ENV == 'container' :
    DEBUG=True
    VERBOSE=False
    # SOLR / ZOOKEEPER CONFIGURATION
    SOLR_COLLECTION = os.getenv('SOLR_COLLECTION')
    ZK_HOST = os.getenv('ZK_HOST')
else:   
    DEBUG=False
    VERBOSE=False


### ENVIRONMENT NON-SPECIFIC CONFIGURATION
# LOCALIZATION CONFIGURATION
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_L10N = True
USE_TZ = True

# DEPENDENCIES
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'api.apps.ApiConfig',
    'navigation.apps.NavigationConfig',
]

# HEADER CONFIGURATION
ALLOWED_HOSTS = ['*']
CORS_ORIGIN_ALLOW_ALL = True
REFERRER_POLICY = 'origin'

# STATIC FILE CONFIGURATION
STATIC_URL = '/static/'
STATICFILES_DIR = [ os.path.join(BASE_DIR, "static") ]
STATIC_ROOT = os.path.join(BASE_DIR, 'static')

# MIDDLEWARE ORDER CONFIGURATION
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'core.middleware.DebugMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# TEMPLATING CONFIGURATION
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
