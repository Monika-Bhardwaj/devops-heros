import pytest
from app import app
@pytest.fixture
def client():
    app.config.update(TESTING=True); return app.test_client()
def test_root(client):
    r=client.get('/'); assert r.status_code==200 and r.json['service']=='final-devops-api'
def test_health(client): assert client.get('/health').json['status']=='healthy'
def test_ready(client): assert client.get('/ready').status_code==200
def test_config(client,monkeypatch):
    monkeypatch.setenv('APP_ENV','test'); assert client.get('/config').json['environment']=='test'
