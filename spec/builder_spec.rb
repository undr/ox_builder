require 'spec_helper'

describe Ox::Builder do
  context do
    subject{Ox::Builder.document}

    it 'should create Ox:Document with Ox::Instruct' do
      subject.should be_instance_of(Ox::Builder::Proxy)
      subject.node.should be_instance_of(Ox::Document)
      subject.to_s.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    end
  end

  context do
    subject{Ox::Builder.document(version: '1.1', 'encoding' => 'cp1251')}

    it 'should create  Ox:Document with Ox::Instruct with attributes' do
      subject.should be_instance_of(Ox::Builder::Proxy)
      subject.node.should be_instance_of(Ox::Document)
      subject.to_s.should == "<?xml version=\"1.1\" encoding=\"cp1251\"?>\n"
    end
  end

  context do
    subject do
      Ox::Builder.document do |doc|
        doc.element('RootNode', key1: 'value #1', key2: 'Value #2') do |root|
          root.comment('Commented text')
          root.element('Node') do |node|
            node.cdata('Safety text')
          end
          root.element('AnotherNode') do |n|
            n.element('x:Child', 'Node Text', attr1: 'Attr #1', attr2: 'Attr #2')
          end
        end
      end
    end

    it 'should create XML' do
      subject.to_s.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<RootNode key1=\"value #1\" key2=\"Value #2\">\n  <!-- Commented text -->\n  <Node>\n    <![CDATA[Safety text]]>\n  </Node>\n  <AnotherNode>\n    <x:Child attr1=\"Attr #1\" attr2=\"Attr #2\">Node Text</x:Child>\n  </AnotherNode>\n</RootNode>\n"
    end
  end
end
