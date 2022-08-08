#!/usr/bin/python3
""" State Module for HBNB project """
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
from os import getenv


class State(BaseModel, Base):
    """ State class """
    __tablename__ = 'states'
    name = Column(String(128), nullable=False)

    if getenv('HBNB_TYPE_STORAGE') == 'db':
        cities = relationship("City", cascade="all, delete", backref="state",
                              passive_deletes=True)
    else:
        @property
        def cities(self):
            """Return the list of cities"""
            list_city = []
            for k, v in self.all().items():
                if 'City' in k:
                    list_city.append(v)
            return list_city
