try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

package_name = 'snortunsock'
description = 'A Python listener to capture Snort event via the UNIX Socket output'
readme = open('README.rst').read()
requirements = []

# PyPI Readme
long_description = open('README.rst').read()

# Pull in the package
package = __import__(package_name)

package_version = package.__version__


setup(name=package_name,
      version=package_version,
      description=description,
      long_description=long_description,
      url=package.__url__,
      author=package.__author__,
      author_email=package.__author_email__,
      license='Apache License, Version 2.0',
      packages=['snortunsock'],
      classifiers=[
        'Development Status :: 4 - Beta',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache Software License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Utilities',
        'Topic :: Software Development :: Libraries :: Python Modules',
         'Programming Language :: Python :: 2.7',
      ],
      install_requires=requirements,
      zip_safe=False)
