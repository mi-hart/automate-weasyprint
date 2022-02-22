
.PHONY: book identifier schedule all webschedule clean

gen/book.html: book/book.css book/book_template.html places.yaml
gen/identifier.html: identifier/identifier_template.html identifier/identifier.css
gen/schedule.html: schedule/schedule_template.html schedule/schedule.css
gen/web_schedule.html: schedule/web_schedule_template.html

gen:
	mkdir gen

pdf:
	mkdir pdf

gen/book.html gen/identifier.html gen/schedule.html gen/web_schedule.html: \
gen schedule.yaml data.json gen.py identifier/identifier_template.html
	python3 gen.py

pdf/identifier.pdf:  gen/identifier.html pdf
	weasyprint gen/identifier.html pdf/identifier.pdf

pdf/book.pdf: gen/book.html pdf
	weasyprint gen/book.html pdf/book.pdf

pdf/schedule.pdf: gen/schedule.html pdf
	weasyprint gen/schedule.html pdf/schedule.pdf

book: pdf/book.pdf

identifier: pdf/identifier.pdf

schedule: pdf/schedule.pdf

webschedule: gen/web_schedule.html

all: book schedule identifier

clean:
	rm -rf pdf/* gen/*
