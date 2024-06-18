#!/bin/bash

# Build the project
echo "Building the project..."
python3 -m pip install -r req2.txt

echo "Make Migration..."
python3 manage.py makemigrations --noinput
python3 manage.py migrate --noinput

echo "Collect Static..."
python3 manage.py collectstatic --noinput --clear

# Remove any existing user with username "Hassan"
echo "Removing any existing user with username 'Hassan'..."
python3 manage.py shell << EOF
from django.contrib.auth import get_user_model
User = get_user_model()
existing_users = User.objects.filter(username='Hassan')
if existing_users.exists():
    existing_users.delete()
    print("Existing user 'Hassan' removed.")
else:
    print("No existing user with username 'Hassan' found.")
EOF

# Create superuser
echo "Creating superuser 'Hassan'..."
python3 manage.py createsuperuser --noinput --username Hassan --email hassan@example.com
python3 manage.py shell << EOF
from django.contrib.auth.models import User
user = User.objects.get(username='Hassan')
user.set_password('F4c01F03.')
user.save()
EOF
