import sys
from os import path
try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

ROOT_DIR = path.realpath(path.dirname(__file__))
sys.path.insert(0, ROOT_DIR)

version = '0.1'

DEP = [
    'hy>=0.11.1',
]

HYSRC = ['**.hy']

EXTRA_DEP = {
    'test': [
        'pytest>=2.6.4',
    ],
}

try:
    with open('README.rst', 'r') as f:
        readme = f.read()
except:
    readme = ''

setup(
    name="xmlhy",
    version=version,
    author_email='devinwh7@gmail.com',
    url='https://github.com/dwhoman/xmlhy',
    description="XML generator for Hy",
    long_description=readme,
    author='Devin Homan',
    license='BSD-New',
    install_requires=DEP,
    extras_require=EXTRA_DEP,
    packages=['xmlhy'],
    package_data={'xmlhy': HYSRC},
)
