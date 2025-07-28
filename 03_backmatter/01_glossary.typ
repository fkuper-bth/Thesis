#import "/etc/utils.typ"
#import "/etc/glossary_entries.typ"

#set heading(numbering: none)
#show: utils.make-glossary

= Glossar <glossary>
#utils.print-glossary(glossary_entries.list, show-all: true)
