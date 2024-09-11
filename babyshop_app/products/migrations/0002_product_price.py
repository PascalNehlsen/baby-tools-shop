# Generated by Django 4.0.2 on 2022-02-21 14:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='product',
            name='price',
            field=models.DecimalField(decimal_places=2, default=12, max_digits=6),
            preserve_default=False,
        ),
    ]
