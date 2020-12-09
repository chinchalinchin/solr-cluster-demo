from django.contrib import admin
from django.urls import path, include

app_name='core'

urlpatterns = [
    path('', include('navigation.urls', namespace='navigation')),
    path('admin/', admin.site.urls),
    path('api/v1/', include('api.urls')),
]
