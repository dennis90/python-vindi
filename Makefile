.PHONY: clean-pyc

default: test

clean-pyc:
	@find . -iname '*.py[co]' -delete
	@find . -iname '__pycache__' -delete
	@find . -iname '.coverage' -delete

clean-dist:
	@rm -rf dist/
	@rm -rf build/
	@rm -rf *.egg-info

clean: clean-pyc clean-dist

test:
	py.test -vvv --cov=vindi tests

dist: clean
	python setup.py sdist
	python setup.py bdist_wheel

release: dist
	git tag `python setup.py -q version`
	git push origin `python setup.py -q version`
	twine upload dist/*
